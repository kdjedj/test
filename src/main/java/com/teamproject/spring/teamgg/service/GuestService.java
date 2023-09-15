package com.teamproject.spring.teamgg.service;


import java.util.List;

import com.teamproject.spring.teamgg.vo.GuestVO;

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
}
