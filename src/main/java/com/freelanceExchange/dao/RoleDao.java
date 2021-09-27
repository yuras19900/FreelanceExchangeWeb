package com.freelanceExchange.dao;

import com.freelanceExchange.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleDao extends JpaRepository<Role, Integer> {
}
