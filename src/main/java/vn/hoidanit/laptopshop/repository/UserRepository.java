package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.User;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @SuppressWarnings("unchecked")
    User save(User daominhduc);

    List<User> findByEmail(String email);

    User findById(long id);

    void deleteById(long id);

    boolean existsByEmail(String email);

}
