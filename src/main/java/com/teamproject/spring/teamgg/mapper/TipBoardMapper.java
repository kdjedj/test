package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import com.teamproject.spring.teamgg.vo.TipBoardVo;

public interface TipBoardMapper {
	public List<TipBoardVo> tipList(int page);
	public TipBoardVo tipRead(long t_idx);
	public void tipDel(long t_idx);
	public void tipWrite(TipBoardVo tvo);
	public void tipModify(TipBoardVo tvo);
	public int getTotalCount();
	public String getAuthorNickname(long t_idx);
}
