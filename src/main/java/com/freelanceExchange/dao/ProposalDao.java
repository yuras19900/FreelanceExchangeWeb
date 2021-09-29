package com.freelanceExchange.dao;

import com.freelanceExchange.model.Order;
import com.freelanceExchange.model.Proposal;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProposalDao extends JpaRepository<Proposal, Integer> {
    List<Proposal> findProposalByOrder(Order order);
    Proposal getProposalByOrder(Order order);
    Proposal getProposalByOrderAndDeclinedIsFalse(Order order);
}
