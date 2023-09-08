package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import com.teamproject.spring.teamgg.vo.GuestVO;

public interface GuestMapper {
	public List<GuestVO> getList(int page);
	public GuestVO read(long bno);
	public void del(long bno);
	public void write(GuestVO gvo);
	public void modify(GuestVO gvo);
	public int getTotalCount();
}
