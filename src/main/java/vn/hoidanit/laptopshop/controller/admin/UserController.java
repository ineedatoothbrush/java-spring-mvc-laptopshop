package vn.hoidanit.laptopshop.controller.admin;

import java.io.File;
import java.security.SecureRandom;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
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
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;
    public final PasswordEncoder passwordEncoder;
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final SecureRandom random = new SecureRandom();

    public UserController(UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user/create")
    public String showCreateForm(Model model) {
        User user = new User();
        StringBuilder sb = new StringBuilder(4);
        // Ví dụ tự sinh mã user
        String email = "";
        String password = "";
        String phone = "0";
        String fullname = "";
        String address = "";
        for (int i = 0; i < 5; i++) {
            email = sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length()))).toString() + "@gmail.com";
        }
        for (int i = 0; i < 10; i++) {
            phone = phone += (int) (Math.random() * 10);
            password = sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length()))).toString();
            fullname = sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length()))).toString();
            address = sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length()))).toString();
        }
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setFullName(fullname);
        user.setAddress(address);
        model.addAttribute("newUser", user);
        return "admin/user/create";
    }

    @RequestMapping("/admin/user")
    public String getUserPage(Model model) {
        List<User> users = this.userService.getAllUser();
        model.addAttribute("users", users);
        return "/admin/user/show";
    }

    @RequestMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "/admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(Model model, @ModelAttribute("newUser") @Valid User daominhduc,
            BindingResult bindingResult,
            @RequestParam("daominhducFile") MultipartFile file) {

        if (bindingResult.hasErrors()) {
            // trả model và bindingResult về view
            return "admin/user/create";
        }

        String avatar = this.uploadService.handleSaveUploadAvatar(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(daominhduc.getPassword());

        daominhduc.setAvatar(avatar);
        daominhduc.setPassword(hashPassword);
        daominhduc.setRole(this.userService.getRoleByName(daominhduc.getRole().getName()));

        this.userService.handleSaveUser(daominhduc);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/detail-{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "/admin/user/detail";
    }

    @RequestMapping("/admin/user/update-{id}")
    public String getUserUpdatePage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("update", user);
        return "/admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUserUpdatePage(Model model, @ModelAttribute("update") User updateUser) {
        User currentUser = this.userService.getUserById(updateUser.getId());
        if (currentUser != null) {
            currentUser.setAddress(updateUser.getAddress());
            currentUser.setPhone(updateUser.getPhone());
            currentUser.setFullName(updateUser.getFullName());
            currentUser.setRole(this.userService.getRoleByName(updateUser.getRole().getName()));
            userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete-{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("delete", new User());
        return "/admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUserPage(Model model, @ModelAttribute("delete") User deleteUser) {
        User currentUser = this.userService.getUserById(deleteUser.getId());
        File file = new File("E:\\My New Project\\laptopshop\\src\\main\\webapp\\resources\\images\\avatar\\"
                + currentUser.getAvatar());
        if (currentUser != null) {
            file.delete();
            userService.handleDeleteUser(deleteUser.getId());
        }
        return "redirect:/admin/user";
    }

}
