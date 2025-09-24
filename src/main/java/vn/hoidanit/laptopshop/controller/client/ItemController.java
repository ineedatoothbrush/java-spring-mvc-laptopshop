package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ch.qos.logback.core.model.Model;

@Controller
public class ItemController {
    @RequestMapping("/product")
    public String getProductDetailPage(Model model) {
        return "/client/product/detail";
    }
}
