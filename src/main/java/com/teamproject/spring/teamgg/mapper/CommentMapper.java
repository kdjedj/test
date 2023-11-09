package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.spring.teamgg.vo.CommentVO;

public interface CommentMapper {
//	Free
	public List<CommentVO> fcList(Long f_idx);
	public CommentVO getFcData(Long fc_idx);
	public void fcDel(Long fc_idx);
	public void fcWrite(CommentVO cvo);
	public void fcModify(CommentVO cvo);
	Integer findLastFcGroupNum(Long f_idx);
    Integer findLastFcNum(@Param("f_idx") Long f_idx, @Param("fc_group") int fc_group);
    public String getWriterByFcIdx(Long fc_idx);
    
//    Tip
	public List<CommentVO> tcList(Long t_idx);
	public CommentVO getTcData(Long tc_idx);
	public void tcDel(Long tc_idx);
	public void tcWrite(CommentVO cvo);
	public void tcModify(CommentVO cvo);
	Integer findLastTcGroupNum(Long t_idx);
    Integer findLastTcNum(@Param("t_idx") Long t_idx, @Param("tc_group") int tc_group);
    public String getWriterByTcIdx(Long tc_idx);
    
//    Comp
	public List<CommentVO> ccList(Long c_idx);
	public CommentVO getCcData(Long cc_idx);
	public void ccDel(Long cc_idx);
	public void ccWrite(CommentVO cvo);
	public void ccModify(CommentVO cvo);
	Integer findLastCcGroupNum(Long c_idx);
    Integer findLastCcNum(@Param("c_idx") Long c_idx, @Param("cc_group") int cc_group);
    public String getWriterByCcIdx(Long cc_idx);
}
