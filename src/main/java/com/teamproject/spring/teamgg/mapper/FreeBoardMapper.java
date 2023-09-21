package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.spring.teamgg.vo.FreeBoardVo;

public interface FreeBoardMapper {
	public List<FreeBoardVo> freeList(int page);
	public FreeBoardVo freeRead(long f_idx);
	public void freeDel(long f_idx);
	public void freeWrite(FreeBoardVo fvo);
	public void freeModify(@Param("fvo") FreeBoardVo fvo, @Param("f_writer") String f_writer);
	public int getTotalCount();
	public String getAuthorNickname(long f_idx);
}
