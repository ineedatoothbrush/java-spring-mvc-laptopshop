package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public String handleService() {
        return "Hello from service";
    }

    public User handleSaveUser(User daominhduc) {
        User test = this.userRepository.save(daominhduc);
        System.out.println(test);
        return test;
    }
}
