package com.teamproject.spring.teamgg.service;
import java.util.List;
import com.teamproject.spring.teamgg.vo.FreeBoardVo;

public interface FreeBoardService {
	public List<FreeBoardVo> getList(int index);
	public FreeBoardVo read(long f_idx);
	public void del(long f_idx);
	public void write(FreeBoardVo fvo);
	public void modify(FreeBoardVo fvo);
	
	public int getStartIndex(int page);
	public int getTotalCount();
	public int getTotalPage();
	public int getTotalBlock(int totalPage);
	
	public String getAuthorId(long f_idx);
}
