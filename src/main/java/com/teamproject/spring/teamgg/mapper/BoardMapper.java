package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import com.teamproject.spring.teamgg.vo.FreeBoardVo;

public interface BoardMapper {
	public List<FreeBoardVo> freeList(int page);
	public FreeBoardVo freeRead(long f_idx);
	public void freeDel(long f_idx);
	public void freeWrite(FreeBoardVo gvo);
	public void freeModify(FreeBoardVo gvo);
	public int getTotalCount();
}
