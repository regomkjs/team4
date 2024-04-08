package kr.kh.team4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.PostDAO;

@Service
public class PostServiceImp implements PostService {
	
	@Autowired
	PostDAO postDAO;
}
