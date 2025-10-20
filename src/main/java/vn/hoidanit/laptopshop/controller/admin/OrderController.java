package vn.hoidanit.laptopshop.controller.admin;

import java.io.File;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.validation.Valid;
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

    @RequestMapping("/admin/order/update-{id}")
    public String getOrderUpdatePage(Model model, @PathVariable long id) {
        Optional<Order> order = this.orderService.fetchOrderById(id);
        model.addAttribute("update", order);
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String postOrderUpdatePage(Model model, @ModelAttribute("update") Order updateOrder) {
        Order currentOrder = this.orderService.fetchOrderById(updateOrder.getId()).get();

        if (currentOrder != null) {
            currentOrder.setStatus(updateOrder.getStatus());
            orderService.handleSaveOrder(currentOrder);
        }
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete-{id}")
    public String getDeleteorderPage(Model model, @PathVariable long id) {
        model.addAttribute("delete", new Order());
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String postDeleteorderPage(Model model, @ModelAttribute("delete") Order deleteOrder) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(deleteOrder.getId());
        if (currentOrder != null) {
            this.orderService.handleDeleteOrder(deleteOrder.getId());
        }
        return "redirect:/admin/order";
    }
}
