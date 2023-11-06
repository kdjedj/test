package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import com.teamproject.spring.teamgg.vo.BoardVO;

public interface BoardMapper {
	
//	FreeBoard
	public List<BoardVO> freeList(int page);
	public int getTotalCountFree();
	public BoardVO freeRead(long f_idx);
	public void freeDel(long f_idx);
	public void freeWrite(BoardVO vo);
	public void freeModify(BoardVO vo);
	
//	TipBoard
	public List<BoardVO> tipList(int page);
	public int getTotalCountTip();
	public BoardVO tipRead(long t_idx);
	public void tipDel(long t_idx);
	public void tipWrite(BoardVO vo);
	public void tipModify(BoardVO vo);
	
//	CompBoard
	public List<BoardVO> compList(int page);
	public int getTotalCountComp();
	public BoardVO compRead(long c_idx);
	public void compDel(long c_idx);
	public void compWrite(BoardVO vo);
	public void compModify(BoardVO vo);
}
