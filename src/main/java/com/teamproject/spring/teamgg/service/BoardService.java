package com.teamproject.spring.teamgg.service;
import java.util.List;
import com.teamproject.spring.teamgg.vo.BoardVO;

public interface BoardService {
	public int getStartIndex(int page);
	public List<BoardVO> getList(int index);

//	FreeBoard
	public int getTotalCountFree();
	public int getTotalPageFree();
	public int getTotalBlockFree(int totalPage);
	public BoardVO freeRead(long f_idx);
	public void freeDel(long f_idx);
	public void freeWrite(BoardVO vo);
	public void freeModify(BoardVO vo);
	
//	TipBoard
	public BoardVO tipRead(long t_idx);
	public int getTotalCountTip();
	public int getTotalPageTip();
	public int getTotalBlockTip(int totalPage);
	public void tipDel(long t_idx);
	public void tipWrite(BoardVO vo);
	public void tipModify(BoardVO vo);
	
//	CompBoard
	public BoardVO compRead(long c_idx);
	public int getTotalCountComp();
	public int getTotalPageComp();
	public int getTotalBlockComp(int totalPage);
	public void compDel(long c_idx);
	public void compWrite(BoardVO vo);
	public void compModify(BoardVO vo);
}
