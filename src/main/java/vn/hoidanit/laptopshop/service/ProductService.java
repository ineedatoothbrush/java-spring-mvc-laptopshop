package vn.hoidanit.laptopshop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService,
            OrderDetailRepository orderDetailRepository, OrderRepository orderRepository) {
        this.productRepository = productRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.userService = userService;
        this.orderDetailRepository = orderDetailRepository;
        this.orderRepository = orderRepository;
    }

    public Product handleSaveProduct(Product laptop) {
        return this.productRepository.save(laptop);
    }

    public List<Product> getAllProduct() {
        return this.productRepository.findAll();
    }

    public Optional<Product> fetchProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void handleDeleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    // Trong file Service của bạn

    @Transactional // Thêm @Transactional để đảm bảo tất cả hoạt động trong một giao dịch
    public void handleAddProductToCart(String email, long productId, HttpSession session) {
        User user = this.userService.getUserByEmail(email);
        if (user == null) {
            return; // Early exit if user not found
        }

        Cart cart = this.cartRepository.findByUser(user);

        // Nếu người dùng chưa có giỏ hàng, tạo mới VÀ LƯU NGAY LẬP TỨC
        if (cart == null) {
            Cart newCart = new Cart();
            newCart.setUser(user);
            // QUAN TRỌNG: Lưu cart ngay lập tức để nó có ID và trở thành persistent
            cart = this.cartRepository.save(newCart);
        }

        Optional<Product> p = this.productRepository.findById(productId);
        if (p.isPresent()) {
            Product realProduct = p.get();

            // Tìm xem sản phẩm đã có trong giỏ chưa
            CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);

            if (oldDetail == null) {
                // Nếu chưa có, tạo CartDetail mới
                CartDetail cd = new CartDetail();
                cd.setCart(cart); // Bây giờ 'cart' đã là persistent, không còn lỗi
                cd.setProduct(realProduct);
                cd.setPrice(realProduct.getPrice());
                cd.setQuantity(1);
                this.cartDetailRepository.save(cd); // Lưu trực tiếp CartDetail
            } else {
                // Nếu có rồi, chỉ tăng số lượng
                oldDetail.setQuantity(oldDetail.getQuantity() + 1);
                this.cartDetailRepository.save(oldDetail);
            }

            // Đếm lại tổng số loại sản phẩm trong giỏ hàng và cập nhật session
            long totalItems = this.cartDetailRepository.countByCart(cart);
            session.setAttribute("sum", totalItems);
        }
    }

    @Transactional
    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);

        if (cartDetailOptional.isEmpty()) {
            return;
        }

        CartDetail cartDetailToRemove = cartDetailOptional.get();
        Cart currentCart = cartDetailToRemove.getCart();
        currentCart.getCartDetails().remove(cartDetailToRemove);

        if (currentCart.getCartDetails().isEmpty()) {
            this.cartRepository.delete(currentCart);
            session.setAttribute("sum", 0);
        } else {
            this.cartRepository.save(currentCart);
            session.setAttribute("sum", currentCart.getCartDetails().size());
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handlePlaceOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone,
            List<Long> selectedItemIds) {

        // Step 1: get cart by user
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            List<CartDetail> selectedCartDetails = new ArrayList<>();

            if (cartDetails != null && !selectedItemIds.isEmpty()) {
                // Filter only selected cart details
                for (CartDetail cd : cartDetails) {
                    if (selectedItemIds.contains(cd.getId())) {
                        selectedCartDetails.add(cd);
                    }
                }

                // Create order with selected items only
                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setStatus("PENDING");

                double sum = 0;
                for (CartDetail cd : selectedCartDetails) {
                    sum += cd.getPrice() * cd.getQuantity();
                }
                order.setTotalPrice(sum);
                order = this.orderRepository.save(order);

                // Create orderDetail for selected items
                for (CartDetail cd : selectedCartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());

                    this.orderDetailRepository.save(orderDetail);
                }

                // Delete only the selected cart details
                for (CartDetail cd : selectedCartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }

                // Update the cart's cartDetails list to remove the selected items
                cartDetails.removeAll(selectedCartDetails);

                // If all items were selected, delete the cart
                if (cartDetails.isEmpty()) {
                    this.cartRepository.deleteById(cart.getId());
                    session.setAttribute("sum", 0);
                } else {
                    // Save the updated cart with remaining items
                    this.cartRepository.save(cart);

                    int remainingQuantity = 0;
                    for (CartDetail cd : cartDetails) {
                        remainingQuantity += cd.getQuantity();
                    }
                    session.setAttribute("sum", remainingQuantity);
                }
            }
        }
    }
}
