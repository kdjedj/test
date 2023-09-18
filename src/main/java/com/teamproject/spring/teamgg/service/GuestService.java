package com.teamproject.spring.teamgg.service;


import java.util.List;

import com.teamproject.spring.teamgg.vo.GuestVO;
import com.teamproject.spring.teamgg.vo.MbinfoVO;
import com.teamproject.spring.teamgg.vo.MemberVO;

public interface GuestService {
	public List<GuestVO> getList(int IndexNunber);
	public GuestVO read(long m_idx);
	public void del(long m_idx);
	public void write(GuestVO gvo);
	public void modify(GuestVO gvo);
	public int getStartIndex(int page);
	public int getTotalCount();
	public int getTotalPage();
	public int getTotalBlock(int totalPage);
	
	public int login_count(MemberVO mv);
	public MbinfoVO login_string(MemberVO mv);
}
