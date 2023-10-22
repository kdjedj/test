package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import com.teamproject.spring.teamgg.vo.MateBoardVo;

public interface MateBoardMapper {
	public List<MateBoardVo> mateList(int page);
	public MateBoardVo mateRead(long m_idx);
	public void mateDel(long m_idx);
	public void mateWrite(MateBoardVo mvo);
	public void mateModify(MateBoardVo mvo);
	public int getTotalCount();
	public String getAuthorNickname(long m_idx);
}
