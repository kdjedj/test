package com.teamproject.spring.teamgg.controller;

import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.service.GuestService;
import com.teamproject.spring.teamgg.vo.GuestVO;
import com.teamproject.spring.teamgg.vo.kw.KWeatherVo;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/guest/*")
@AllArgsConstructor
@Controller
public class GuestController {
		
	private GuestService service;
	
	@GetMapping("/getList")
	public void getList(Model model, @RequestParam("page") int page) {
		//넘어온 페이지 값으로 시작 인덱스 구하기
		int index = service.getStartIndex(page);
		
		//전체 글 수 구하기
		int totalCount = service.getTotalCount();
		log.info("==== 방명록 - 전체 글 수 : "+totalCount);
		
		//todo
		//전체 페이지 수 구하기
		int totalPage = service.getTotalPage();
		log.info("==== 방명록 - 전체 페이지 수 : "+totalPage);
		
		//블럭 당 페이지 수를 정함
		//PAGE_PER_BLOCK
		
		//todo
		//전체 블럭 수 구하기
		//필요값
		//totalPage
		//블럭 당 페이지 수 ( PAGE_PER_BLOCK)
		
		int totalBlock = service.getTotalBlock(totalPage);
		log.info("==== 방명록 - 전체 블럭 수 : "+totalPage);
		
		//현재 페이지로 현재 블럭 번호 구하기
		//총 페이지 블럭페이지값
		int currentBlock = (int)Math.ceil((double)page/ConfigBoard.PAGE_PER_BLOCK);
		log.info("==== 방명록 - 현재 블럭 번호 : "+currentBlock);
		
		//todo
		
		//🐿️🐿️🐿️{블럭 처리 - 3/9}.블럭 시작 페이지 번호 구하기🐿️🐿️🐿️//
		//블럭 시작 페이지 번호 = (현재 블럭 번호 - 1) * 블럭 당 페이지 수 + 1		
		int blockStartNo = (currentBlock - 1) * ConfigBoard.PAGE_PER_BLOCK + 1;
		//🐿️🐿️🐿️{블럭 처리 - 4/9}.블럭 페이지 끝 번호 구하기🐿️🐿️🐿️//
		//블럭 페이지 끝 번호 = 현재 블럭 번호 * 블럭 당 페이지 수		
		int blockEndNo = currentBlock * ConfigBoard.PAGE_PER_BLOCK;
		log.info("==== 방명록 - 현재 블럭 시작 번호 : "+blockStartNo);
		log.info("==== 방명록 - 현재 블럭 끝 번호 : "+blockEndNo);
		
		
		//🐿️🐿️🐿️{블럭 처리 - 6/9}.(이전/다음) 관련 계산 등 처리🐿️🐿️🐿️
		boolean hasPrev = true;	//이전 블럭 가기 가능 여부 저장값 초기화.
		boolean hasNext = true;	//다음 블럭 가기 가능 여부 저장값 초기화.
		int prevPage = 0;
		int nextPage = 0;		
		
		//🐿️🐿️🐿️{블럭 처리 - 6/9}.(이전/다음) 관련 계산 등 처리🐿️🐿️🐿️ 
		//🐿️🐿️🐿️: 현재 블럭에서 이전/다음이 가능한지 계산하고 가능 여부를 저장해두기🐿️🐿️🐿️//
		if(currentBlock == 1){	//현재 블럭이 1번 블럭이면
			hasPrev = false;		//이전 블럭 가기 불가능
		} else {					//현재 블럭이 1번 블럭이 아니면
			hasPrev = true;			//이전 블럭 가기 가능
			//🐿️🐿️🐿️: 이전 블럭 이동 시 몇 페이지로 이동할지 정하기🐿️🐿️🐿️//
			//이전 블럭의 마지막 페이지로 이동하게 하면 됨(보통 이렇게 처리하니까)
			//공식 : (현재 블럭 번호 - 1) * 블럭 당 페이지 수
			prevPage = (currentBlock - 1 ) * ConfigBoard.PAGE_PER_BLOCK;
		}
		if(currentBlock < totalBlock ){	//현재 블럭이 마지막 블럭보다 작으면
			hasNext = true;					//다음 블럭 가기 가능
			//🐿️🐿️🐿️: 다음 블럭 이동 시 몇 페이지로 이동할지 정하기🐿️🐿️🐿️//
			//다음 블럭의 첫 페이지로 이동하게 하면 됨(보통 이렇게 처리하니까)
			//공식 : 현재 블럭 번호 * 블럭 당 페이지 수 + 1
			nextPage = currentBlock * ConfigBoard.PAGE_PER_BLOCK + 1;		
		} else {							//현재 블럭이 마지막 블럭보다 같거나 크면(큰값이 오면 안되겠지만)
			hasNext = false;				//다음 블럭 가기 불가능
		}		
		
		
		//페이지 리스트 뿌리기
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("totalPage",totalPage);
		model.addAttribute("totalBlock",totalBlock);
		model.addAttribute("currentBlock",currentBlock);
		model.addAttribute("blockStartNo",blockStartNo);
		model.addAttribute("blockEndNo",blockEndNo);
		model.addAttribute("hasPrev",hasPrev);
		model.addAttribute("hasNext",hasNext);
		model.addAttribute("prevPage",prevPage);
		model.addAttribute("nextPage",nextPage);
		model.addAttribute("mateList",service.getList(index));
	}
	
	@GetMapping({"/read", "/modify"})
	public void read(@RequestParam("m_idx") Long m_idx, Model model) {
		log.info("컨트롤러 ==== 글번호 ==============="+m_idx);
		model.addAttribute("read",service.read(m_idx));
	}
	
	@GetMapping("/del")
	public String del(@RequestParam("m_idx") Long m_idx) {
		log.info("컨트롤러 ==== 글번호 ==============="+m_idx);
		service.del(m_idx);
		return "redirect:/guest/getList";	// 책 p.245 참고
	}
	
	@PostMapping("/write")
	public String write(GuestVO gvo) {
		service.write(gvo);
		return "redirect:/guest/getList";	// 책 p.245 참고
	}
	
	@GetMapping("/write")	// 책 p.239 /write 중복이지만 이건 글쓰기 화면을 위한 url 매핑
	public void write() {
		
	}
	
	@PostMapping("/modify")
	public String modify(GuestVO gvo) {
		service.modify(gvo);
		return "redirect:/guest/getList";
	}
	
	@RequestMapping("/w")
	public void w() {
	//// 우리나라 공공 api ////			
		//인코딩 인증키			
		String API_KEY = "TDf%2Fho9nOMC2Ho71ocCWLwhwgKl9KBhSyyX67Pylaw%2BN0V7GQsIt%2B7UaJQsN9X%2FrpsIc%2FJJR%2Bltqo30nKyUXjA%3D%3D";
				
		String API_URL = "https://apis.data.go.kr/1360000/"
				+ "AsosDalyInfoService/getWthrDataList"
				+ "?numOfRows=10&pageNo=1&dataCd=ASOS"
				+ "&dateCd=DAY&startDt=20100101&endDt=20100102"
				+ "&stnIds=108&dataType=JSON&serviceKey=" + API_KEY; 
				
//				* 주의 * https 아님 http 임. https 는 인증관련 복잡한 처리를 해야함.	
		RestTemplate restTemplate = new RestTemplate();			
					
		//// **** 중요 **** uri			
		URI uri = null; //java.net.URI 임포트 하셈			
		try {			
			uri = new URI(API_URL);		
		} catch (URISyntaxException e) {			
			e.printStackTrace();		
		}	
		
		String s = restTemplate.getForObject(uri, String.class); //
		log.info("====== 우리나라 날씨 잘 나오나? "+s);
		
		KWeatherVo kw = restTemplate.getForObject(uri, KWeatherVo.class); // 자기 클래스로 바꾸시오..
		log.info("==== json ==== : 우리나라 날씨 잘 나오냐? : "+kw.response.body.dataType);
		String location = kw.response.body.items.item.get(0).stnNm;
		String tMin = kw.response.body.items.item.get(0).minTa;
		String tMax = kw.response.body.items.item.get(0).maxTa;
		String ddara = String.format("==== json ==== : 어제의 날씨입니다~ 어제 %s 의 최저기온은 %s 도 최고 기온은 %s 였습니다. 날씨였습니다.", location, tMin, tMax);
		log.info(ddara);
	}
	
	@RequestMapping("/test")
	public void test(HttpServletRequest request,Model m) {
		setCp(m,request.getContextPath());
		m.addAttribute("a","개");
		m.addAttribute("b","삵");
	}
	
	public void setCp(Model m, String cp) {
		m.addAttribute("cp",cp);
		log.info("==== 컨텍스트 패스임:"+cp);
	}
	
	@RequestMapping("/test2")
	public void test2() {
		
	}
	
	@RequestMapping("/testapi")
	public void testapi() {
		
	}
}
