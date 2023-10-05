package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import com.teamproject.spring.teamgg.vo.GuestVO;
import com.teamproject.spring.teamgg.vo.MbinfoVO;
import com.teamproject.spring.teamgg.vo.MemberVO;

public interface GuestMapper {
	public List<GuestVO> getList(int IndexNumber);
	public GuestVO read(long m_idx);
	public void del(long m_idx);
	public void write(GuestVO gvo);
	public void modify(GuestVO gvo);
	public int getTotalCount();
	
	public int login_count(MemberVO mv);
	public MbinfoVO login_string(MemberVO mv);
}
