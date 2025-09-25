package vn.hoidanit.laptopshop.controller.admin;

import java.security.SecureRandom;
import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.domain.Product;

@Controller
public class ProductController {

    private final ProductService productService;
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final SecureRandom random = new SecureRandom();

    ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/admin/product/create")
    public String showCreateForm(Model model) {
        Product product = new Product();
        StringBuilder sb = new StringBuilder(4);
        Random rand = new Random();
        double randomDouble = rand.nextDouble() * 1000;
        // Ví dụ tự sinh mã user

        String name = "";
        double price = 0;
        String detailDesc = "";
        String shortDesc = "";
        long quantity = 0;

        for (int i = 0; i < 5; i++) {
            name = "Laptop " + sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length()))).toString();
        }
        for (int i = 0; i < 100; i++) {
            detailDesc = sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length()))).toString();

        }
        for (int i = 0; i < 10; i++) {
            shortDesc = sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length()))).toString();
        }
        quantity = rand.nextLong(300);
        price = Math.round(randomDouble * 1000.0) / 100.0;
        product.setName(name);
        product.setPrice(price);
        product.setDetailDesc(detailDesc);
        product.setShortDesc(shortDesc);
        product.setQuantity(quantity);
        model.addAttribute("newProduct", product);
        return "admin/product/create";
    }

    @GetMapping("/admin/product")
    public String getProduct(Model model) {
        List<Product> products = this.productService.getAllProduct();
        model.addAttribute("products", products);
        return "/admin/product/show";
    }

    @RequestMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "/admin/product/create";
    }

    @PostMapping(value = "/admin/product/create")
    public String createProductPage(Model model, @ModelAttribute("newProduct") Product laptop) {
        this.productService.handleSaveProduct(laptop);
        return "redirect:/admin/product";
    }
}
