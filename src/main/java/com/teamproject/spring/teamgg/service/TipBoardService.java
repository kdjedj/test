package com.teamproject.spring.teamgg.service;
import java.util.List;
import com.teamproject.spring.teamgg.vo.TipBoardVo;

public interface TipBoardService {
	public List<TipBoardVo> getList(int page);
	public TipBoardVo read(long t_idx);
	public void del(long t_idx);
	public void write(TipBoardVo tvo);
	public void modify(TipBoardVo tvo);
	
	public int getStartIndex(int page);
	public int getTotalCount();
	public int getTotalPage();
	public int getTotalBlock(int totalPage);
	
	public String getAuthorNickname(long t_idx);
}
