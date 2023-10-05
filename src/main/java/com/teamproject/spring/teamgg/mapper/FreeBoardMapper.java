package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import com.teamproject.spring.teamgg.vo.FreeBoardVo;

public interface FreeBoardMapper {
	public List<FreeBoardVo> freeList(int page);
	public FreeBoardVo freeRead(long f_idx);
	public void freeDel(long f_idx);
	public void freeWrite(FreeBoardVo fvo);
	public void freeModify(FreeBoardVo fvo);
	public int getTotalCount();
	public String getAuthorId(long f_idx);
}
