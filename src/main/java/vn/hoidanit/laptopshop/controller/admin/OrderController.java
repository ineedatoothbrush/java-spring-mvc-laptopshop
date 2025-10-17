package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.service.OrderService;

@Controller
public class OrderController {

    private final OrderService orderService;

    OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrders(Model model) {
        List<Order> orders = this.orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @RequestMapping("/admin/order/detail-{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Optional<Order> order = this.orderService.fetchOrderById(id);
        List<OrderDetail> orderDetails = order.get().getOrderDetails();
        model.addAttribute("orderDetails", orderDetails);
        return "admin/order/detail";
    }

}
