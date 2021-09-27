package com.freelanceExchange.service;

import com.freelanceExchange.dao.RoleDao;
import com.freelanceExchange.dao.UserDao;
import com.freelanceExchange.model.Role;
import com.freelanceExchange.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {

    @PersistenceContext
    private EntityManager em;

    @Autowired
    UserDao userDao;

    @Autowired
    RoleDao roleDao;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userDao.findByUsername(username);
        if (user == null){
            throw new UsernameNotFoundException("User not found");
        }
        return user;
    }

    public User findUserById(Integer userId){
        Optional<User> userFromDb = userDao.findById(userId);
        return userFromDb.orElse(new User());
    }

    public List<User> allUsers(){
        return userDao.findAll();
    }

    public boolean saveUser(User user){
        User userFromDb = userDao.findByUsername(user.getUsername());

        if(userFromDb != null){
            return false;
        }
        user.setRoles(Collections.singleton(new Role(1, "ROLE_USER")));
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setActive(true);
        userDao.save(user);
        return true;
    }
}
