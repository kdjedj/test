package com.teamproject.spring.teamgg.service;
import java.util.List;
import com.teamproject.spring.teamgg.vo.MateBoardVo;

public interface MateBoardService {
	public List<MateBoardVo> getList(int page);
	public MateBoardVo read(long m_idx);
	public void del(long m_idx);
	public void write(MateBoardVo mvo);
	public void modify(MateBoardVo mvo);
	
	public int getStartIndex(int page);
	public int getTotalCount();
	public int getTotalPage();
	public int getTotalBlock(int totalPage);
	
	public String getAuthorNickname(long m_idx);
}
