package vn.hoidanit.laptopshop.controller.admin;

import java.io.File;
import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.domain.Product;

@Controller
public class ProductController {

    private final UploadService uploadService;
    private final ProductService productService;
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/product/create")
    public String showCreateForm(Model model) {
        Product product = new Product();
        Random rand = new Random();
        double randomDouble = rand.nextDouble() * 1000;

        // name 5 ký tự
        StringBuilder sbName = new StringBuilder();
        for (int i = 0; i < 5; i++) {
            sbName.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        String name = "Laptop " + sbName;

        // detailDesc 100 ký tự
        StringBuilder sbDetail = new StringBuilder();
        for (int i = 0; i < 100; i++) {
            sbDetail.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        String detailDesc = sbDetail.toString();

        // shortDesc 5 ký tự
        StringBuilder sbShort = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            sbShort.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        String shortDesc = sbShort.toString();

        long quantity = rand.nextLong(300);
        double price = Math.round(randomDouble * 1000.0) / 100.0;

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
    public String createProductPage(Model model, @ModelAttribute("newProduct") @Valid Product laptop,
            BindingResult bindingResult, @RequestParam("daominhducFile") MultipartFile file) {
        if (bindingResult.hasErrors()) {
            // trả model và bindingResult về view
            return "/admin/product/create";
        }
        String picture = this.uploadService.handleSaveUploadLaptopPicture(file, "product");
        laptop.setImage(picture);
        this.productService.handleSaveProduct(laptop);
        return "redirect:/admin/product";
    }

    @RequestMapping("/admin/product/detail-{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product products = this.productService.getProductById(id);
        model.addAttribute("product", products);
        return "/admin/product/detail";
    }

    @GetMapping("/admin/product/delete-{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        model.addAttribute("delete", new Product());
        return "/admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProductPage(Model model, @ModelAttribute("delete") Product deleteProduct) {
        Product currentProduct = this.productService.getProductById(deleteProduct.getId());
        File file = new File("E:\\My New Project\\laptopshop\\src\\main\\webapp\\resources\\images\\product\\"
                + currentProduct.getImage());
        if (currentProduct != null) {
            file.delete();
            this.productService.handleDeleteProduct(deleteProduct.getId());
        }
        return "redirect:/admin/product";
    }

    @RequestMapping("/admin/product/update-{id}")
    public String getProductUpdatePage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("update", product);
        return "/admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postUserUpdatePage(Model model, @ModelAttribute("update") Product updateProduct) {
        Product currentProduct = this.productService.getProductById(updateProduct.getId());

        if (currentProduct != null) {
            currentProduct.setName(updateProduct.getName());
            currentProduct.setPrice(updateProduct.getPrice());
            currentProduct.setDetailDesc(updateProduct.getDetailDesc());
            currentProduct.setShortDesc(updateProduct.getShortDesc());
            currentProduct.setFactory(updateProduct.getFactory());
            currentProduct.setTarget(updateProduct.getTarget());
            productService.handleSaveProduct(currentProduct);
        }
        return "redirect:/admin/product";
    }
}
