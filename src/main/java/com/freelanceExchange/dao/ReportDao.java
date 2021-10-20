package com.freelanceExchange.dao;

import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.Report;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReportDao extends JpaRepository<Report, Integer> {
    List<Report> findReportsByOrder(Order order);
}
