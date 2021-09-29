package com.freelanceExchange.service;

import com.freelanceExchange.dao.ProposalDao;
import com.freelanceExchange.model.Proposal;
import com.freelanceExchange.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;

@Service
public class ProposalService {

    @Autowired
    private ProposalDao proposalDao;

    public void saveProposal(Proposal proposal, @AuthenticationPrincipal User user){
        proposal.setUser(user);
        proposal.setDeclined(false);
        proposalDao.save(proposal);
    }
}
