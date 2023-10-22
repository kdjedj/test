package com.teamproject.spring.teamgg.service;
import java.util.List;
import com.teamproject.spring.teamgg.vo.CompBoardVo;

public interface CompBoardService {
	public List<CompBoardVo> getList(int page);
	public CompBoardVo read(long c_idx);
	public void del(long c_idx);
	public void write(CompBoardVo cvo);
	public void modify(CompBoardVo cvo);
	
	public int getStartIndex(int page);
	public int getTotalCount();
	public int getTotalPage();
	public int getTotalBlock(int totalPage);
	
	public String getAuthorNickname(long c_idx);
}
