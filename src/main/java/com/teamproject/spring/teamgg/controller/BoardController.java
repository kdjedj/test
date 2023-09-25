package com.teamproject.spring.teamgg.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.peisia.spring.spb.lol.BasisicLoginVo;
import com.peisia.spring.spb.lol.Cat;
import com.peisia.spring.spb.lol.Summoner;
import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.service.GuestService;
import com.teamproject.spring.teamgg.vo.GuestVO;
import com.teamproject.spring.teamgg.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
@Controller
public class BoardController {
private GuestService service;
	@GetMapping("/Searching_User")
	public void Searching_User() {
		log.info("=====서칭 유저 컨트롤러 한번 다녀감");
	}
	
//	@GetMapping("/teamMate")
//	public void teamMate() {
//		log.info("=====팀메이트 컨트롤러 한번 다녀감");
//	}

	
	@GetMapping("/teamMate")
	public void teamMate(Model model, @RequestParam(value="Page", defaultValue="1") int page
			, MemberVO mv) {  //MemberVO는 기본값 못만드나?
		
		//넘어온 로그인 값
		log.info("teamMate 아이디 값 =========== "+mv.getM_id());
		log.info("teamMate 패스워드 값 =========== "+mv.getM_pw());
		
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
		
		if(service.login_count(mv)!=0) {
			log.info("로그인 함수 실행됨");
			model.addAttribute("login_on",service.login_string(mv));
		}
		
		
		
	}
	
	@GetMapping({"/mate_read", "/mate_modify"})
	public void mateRead(@RequestParam("m_idx") Long m_idx, Model model, MemberVO mv) {
		
		log.info("읽기 컨트롤러 ==== 글번호 ==============="+m_idx);
		log.info("읽기 컨트롤러 ==== 글id ==============="+mv.getM_id());
		log.info("읽기 컨트롤러 ==== 글pw ==============="+mv.getM_pw());

		
		model.addAttribute("read",service.read(m_idx));
		model.addAttribute("idAndPw",mv);
	}
	
	@GetMapping("/del")
	public String del(@RequestParam("m_idx") Long m_idx) {
		log.info("컨트롤러 ==== 글번호 ==============="+m_idx);

		service.del(m_idx);
		return "redirect:/board/teamMate";	// 책 p.245 참고
	}
	
	@PostMapping("/mate_write")
	public String mate_write(GuestVO gvo, MemberVO mv) {
		log.info("글쓰기 post컨트롤러 ==== 글쓴이 ==============="+gvo.getM_writer());
		service.write(gvo);
		return "redirect:/board/teamMate?m_id="+mv.getM_id()+"&m_pw="+mv.getM_pw();	// 책 p.245 참고
	}
	
	@GetMapping("/mate_write")	// 
	public void mate_write(Model model, @RequestParam("user") String user, MemberVO mv) {
		log.info("글쓰기 get컨트롤러 ==== 유저이름 ==============="+user);
		log.info("글쓰기 get컨트롤러 ==== 유저id ==============="+mv.getM_id());
		log.info("글쓰기 get컨트롤러 ==== 유저pw ==============="+mv.getM_pw());

		
		
		model.addAttribute("user",user);
		model.addAttribute("idAndPw",mv);
		
	}
	
	@PostMapping("/mate_modify")
	public String modify(GuestVO gvo, MemberVO mv) {
		log.info("수정 컨트롤러 ==== 글id ==============="+mv.getM_id());
		log.info("수정 컨트롤러 ==== 글pw ==============="+mv.getM_pw());
		log.info("수정 컨트롤러 ==== 글idx ==============="+gvo.getM_idx());
		
		service.modify(gvo);
		return "redirect:/board/teamMate?m_id="+mv.getM_id()+"&m_pw="+mv.getM_pw();
	}
	
	@GetMapping("/login_admin")
	public String login_admin(MemberVO mv) {
		log.info("컨트롤러 ==== 글id ==============="+mv.getM_id());
		log.info("컨트롤러 ==== 글pw ==============="+mv.getM_pw());
		return "redirect:/board/teamMate?m_id="+mv.getM_id()+"&m_pw="+mv.getM_pw();	// 책 p.245 참고
	}
	
	@RequestMapping("/searching_player")
	public void searching_player(@RequestParam("userName") String userName, HttpServletRequest request, Model model) {
	//// 우리나라 공공 api ////			
		//인코딩 인증키			
		String API_KEY = "RGAPI-0092f94c-82f2-4df3-ad25-ac35254f878e";
				
		String API_URL = "https://kr.api.riotgames.com/lol/summoner/v4"
				+ "/summoners/by-name/"
				+ userName
				+ "?api_key=" + API_KEY; 
				
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
		log.info("====== 로그인 정보 잘 나오나?? "+s);
		
		BasisicLoginVo bc = restTemplate.getForObject(uri, BasisicLoginVo.class); // 자기 클래스로 바꾸시오..
		log.info("==== json ==== : 유저이름? : "+bc.name);
		String accountId = bc.accountId;
		String id = bc.id;
		String puuid = bc.puuid;
//		String location = kw.response.body.items.item.get(0).stnNm;
//		String tMin = kw.response.body.items.item.get(0).minTa;
//		String tMax = kw.response.body.items.item.get(0).maxTa;
		String ddara = String.format("==== json ==== : 해당 검색 유저의 이름은 %s 입니다. 계정 id값은 %s 입니다", bc.name, accountId);
		log.info(ddara);
	
	
		
		
		String INFO_API_URL = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/"
				+ id
				+ "?api_key=" + API_KEY; 
		
//				* 주의 * https 아님 http 임. https 는 인증관련 복잡한 처리를 해야함.	
		
		//// **** 중요 **** uri			
		URI lol_uri = null; //java.net.URI 임포트 하셈			
		try {			
			lol_uri = new URI(INFO_API_URL);		
		} catch (URISyntaxException e) {			
			e.printStackTrace();		
		}	
		
		String b = restTemplate.getForObject(lol_uri, String.class); //
		log.info("====== 유저 정보 잘 나오나?? "+b);
		
		List<Map<String, Object>> lolbc = restTemplate.getForObject(lol_uri, List.class); // 자기 클래스로 바꾸시오..
		log.info("==== json ==== : 해당 유저 티어는? : "+lolbc.get(0).get("tier"));
		String queueType = (String)lolbc.get(0).get("queueType");
    	String tier = (String)lolbc.get(0).get("tier");
		String rank = (String)lolbc.get(0).get("rank");
		System.out.println("자료형 확인:"+lolbc.get(0).get("leaguePoints").getClass().getName());

		Integer leaguePoints = (Integer)lolbc.get(0).get("leaguePoints");
		log.info("==== json ==== : 해당 유저 리그포인트는? : "+leaguePoints);
		
		System.out.println("자료형 확인:"+lolbc.get(0).get("wins").getClass().getName());
		Integer wins = (Integer)lolbc.get(0).get("wins");

		System.out.println("자료형 확인:"+lolbc.get(0).get("losses").getClass().getName());
		Integer losses = (Integer)lolbc.get(0).get("losses");

		String ddaralol = String.format("==== json ==== : 본 통계는 %s를 기반으로 만들어졌습니다"
				+ "해당 유저의 티어는 %s이며, 랭크는%s , %s번 이겼고, %s번 져서 리그포인트는 %s점 입니다", queueType, tier, rank
				,wins, losses, leaguePoints);
		log.info(ddaralol);
		
		log.info("==== json ==== : 해당 유저 랭크는? : "+rank);
		
		
		
		
		String TEST_URL = "https://asia.api.riotgames.com/lol/match/v5/matches/"
				+ "KR_6717857983"
				+"?api_key="+API_KEY; 
		
//				* 주의 * https 아님 http 임. https 는 인증관련 복잡한 처리를 해야함.	
		
		//// **** 중요 **** uri			
		URI test_uri = null; //java.net.URI 임포트 하셈			
		try {			
			test_uri = new URI(TEST_URL);		
		} catch (URISyntaxException e) {			
			e.printStackTrace();		
		}	
		
//		String f = restTemplate.getForObject(test_uri, String.class); //
//		log.info("====== 해당 정보 잘 나오나?? "+f);
//		
		Cat testbc = restTemplate.getForObject(test_uri, Cat.class); // 자기 클래스로 바꾸시오..
//		String player1 = (String)testbc.metadata.partic.participant.get(0).player1;
//		log.info("==== json ==== : 플레이어1의 id값은?? : "+player1);
		
		String dataVersion = (String)testbc.metadata.dataVersion;
		log.info("==== json ==== : 데이타 버전 값은?? : "+dataVersion);
		
		List<String> players = (List<String>)testbc.metadata.participants;
		String championName = (String)testbc.info.participants.get(0).championName;
		log.info("==== json ==== 챔피언 이름 : "+championName);
		String gameType = (String)testbc.info.gameType;
		log.info("==== json ==== 게임 타입 : "+gameType);
		
		String item0 = testbc.info.participants.get(0).item0;
		log.info("==== json ==== 아이템 고윳값 번호 : "+item0);
		
		for(int i=0; i<=6; i++) {
			System.out.println("자료형 확인:"+testbc.info.participants.get(i).item0.getClass().getName());
		}
		
		
		
		
		
		for(String participants : players){
			
			log.info("==== json ==== 플레이어 id 값 : "+participants);
		}
		
		
		// match 정보 받아오기 
		
		BufferedReader br = null;
		
		Summoner temp= null;
		try{            
			String urlstr = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/"+
					userName+"?api_key="+API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8")); // 여기에 문자열을 받아와라.
			String result = "";
			String line;
			while((line = br.readLine()) != null) { // 그 받아온 문자열을 계속 br에서 줄단위로 받고 출력하겠다.
				result = result + line;
			}
			JsonParser jsonParser = new JsonParser();
			JsonObject k = (JsonObject) jsonParser.parse(result);
			String name_a = k.get("name").getAsString();
			log.info("==== json ==== : 해당 유저 이름은 무엇인가요? : "+name_a);
			String puuid_a = k.get("puuid").getAsString();
			Double profileIconId = k.get("profileIconId").getAsDouble();
			int profileIconId_int = (int)Math.ceil((double) profileIconId);
			log.info("==== json ==== : 해당 유저 아이콘 번호 무엇인가요? : "+profileIconId_int);

			Double summonerLevel_a = k.get("summonerLevel").getAsDouble();
			Double revisionDate_a = k.get("revisionDate").getAsDouble();
			String id_a = k.get("id").getAsString();
			String accountId_a = k.get("accountId").getAsString();

			temp = new Summoner(profileIconId_int,bc.name,puuid_a,summonerLevel_a,revisionDate_a,id_a,accountId_a);
			
			String ddaratest = String.format("==== json ==== : 소환사의 프로필사진 코드는 %s이고, 이름은 %s, 공용id는 %s, 레벨은 %s,"
					+ " 리비젼데이트는 %s이며, 아이디는 %s, 계정 고유 아이디는 %s입니다 ", 
					profileIconId, bc.name, puuid_a, summonerLevel_a, revisionDate_a, id_a,accountId_a);
			log.info(ddaratest);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		
		
		
		
//		String matchId= "KR_6717857983";
//		try{            
//			String urlstr1 = "https://asia.api.riotgames.com/lol/match/v5/matches/"
//					+ matchId
//					+ "/timeline"
//					+"?api_key="+API_KEY;
//			URL url1 = new URL(urlstr1);
//			HttpURLConnection urlconnection1 = (HttpURLConnection) url1.openConnection();
//			urlconnection1.setRequestMethod("GET");
//			br = new BufferedReader(new InputStreamReader(urlconnection1.getInputStream(),"UTF-8")); // 여기에 문자열을 받아와라.
//			String result = "";
//			String line;
//			while((line = br.readLine()) != null) { // 그 받아온 문자열을 계속 br에서 줄단위로 받고 출력하겠다.
//				result = result + line;
//			}
//			JsonParser jsonParser = new JsonParser();
//			JsonObject k = (JsonObject) jsonParser.parse(result);
//			Double frameInterval = k.get("frameInterval").getAsDouble();
//			log.info("==== json ==== : 해당 인터벌 프레임 값은?? : "+frameInterval);
//
//		}catch(Exception e){
//			System.out.println(e.getMessage());
//		}
		log.info("===================통과선=====================");

		
 		model.addAttribute("summoner", temp);
		model.addAttribute("profile_img", "http://ddragon.leagueoflegends.com/cdn/13.18.1/img/profileicon/"+temp.getProfileIconId()+".png");
	//	model.addAttribute("Item_imgURL", "https://ddragon.leagueoflegends.com/cdn/13.18.1/img/item/"++".png");
	
		
		
		
		
        
		
		
	
	
	}
	
}
