package vn.hoidanit.laptopshop;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    @GetMapping("/")
    public String index() {
        return "Hello World with";
    }

    @GetMapping("/user")
    public String userPage() {
        return "User Only";
    }

    @GetMapping("/admin")
    public String adminPage() {
        return "Admin Only";
    }
}
