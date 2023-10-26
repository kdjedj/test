package com.teamproject.spring.teamgg.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.peisia.spring.spb.lol.Cat;
import com.peisia.spring.spb.lol.DetailInfo;
import com.peisia.spring.spb.lol.GameInfo;
import com.peisia.spring.spb.lol.GradeInfo;
import com.peisia.spring.spb.lol.LoginInfoVo;
import com.peisia.spring.spb.lol.Lol_api;
import com.peisia.spring.spb.lol.Participants;
import com.peisia.spring.spb.lol.Positions;
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
	
	@RequestMapping("/exist_user")
	public String exist_user(@RequestParam("userName") String userName, @RequestParam("region") String region,
			HttpServletRequest request, Model model)  throws UnsupportedEncodingException {
		String SurmmonerName = userName.replaceAll(" ", "%20");
//		System.out.println("검색어에 적은 유저이름은? : "+SurmmonerName);
//		System.out.println("넘어온 지역 번호는? : " +region);
		String API_KEY = "RGAPI-0092f94c-82f2-4df3-ad25-ac35254f878e";
		HttpSession session = request.getSession();
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		BufferedReader br = null;
		
		Summoner temp= null;
		try{            
			String urlstr = "https://"+region+".api.riotgames.com/lol/summoner/v4/summoners/by-name/"+
					SurmmonerName+"?api_key="+API_KEY;
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
			Double summonerLevel_a = k.get("summonerLevel").getAsDouble();
			Double revisionDate_a = k.get("revisionDate").getAsDouble();
			String id_a = k.get("id").getAsString();
			String accountId_a = k.get("accountId").getAsString();

			temp = new Summoner(profileIconId_int,name_a,puuid_a,summonerLevel_a,revisionDate_a,id_a,accountId_a);
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		if(temp==null) {
			return "redirect:/board/no_search";
		}
		String utrName = URLEncoder.encode(SurmmonerName, "UTF-8");
		SurmmonerName = utrName.replaceAll("%25", "%");
		System.out.println("다음으로 넘어가는 이름은? : "+SurmmonerName);
		session.setAttribute("temp", temp);
		return "redirect:/board/searching_player?userName="+SurmmonerName+"&region="+region;
	}
	
	@RequestMapping("/no_search")
	public void no_search() {
		System.out.println("한번 지나감 ");
	}
	
	@RequestMapping("/searching_player")
	public void searching_player(@RequestParam("userName") String userName, @RequestParam("region") String region,
			HttpServletRequest request, Model model) {
	//// 우리나라 공공 api ////			
		//인코딩 인증키		
		DetailInfo dInfo = new DetailInfo();
		RestTemplate restTemplate = new RestTemplate();			
		BufferedReader br = null;
		String API_KEY = "RGAPI-0092f94c-82f2-4df3-ad25-ac35254f878e";
		//세션에서 값 불러오기
		HttpSession session = request.getSession();
		Summoner temp= (Summoner)session.getAttribute("temp");
		
//		System.out.println("검색어에 적은 유저이름은? : "+userName);
//		System.out.println("넘어온 지역 번호는? : " +region);

//		String SurmmonerName = userName.replaceAll(" ", "%20");
//		String API_URL = "https://kr.api.riotgames.com/lol/summoner/v4"
//				+ "/summoners/by-name/"
//				+ SurmmonerName
//				+ "?api_key=" + API_KEY; 
//				
////				* 주의 * https 아님 http 임. https 는 인증관련 복잡한 처리를 해야함.	
//					
//		//// **** 중요 **** uri			
//		URI uri = null; //java.net.URI 임포트 하셈			
//		try {			
//			uri = new URI(API_URL);		
//		} catch (URISyntaxException e) {			
//			e.printStackTrace();		
//		}	
//		
////		String s = restTemplate.getForObject(uri, String.class); //
////		log.info("====== 로그인 정보 잘 나오나?? "+s);
//		
//		BasisicLoginVo bc = restTemplate.getForObject(uri, BasisicLoginVo.class); // 자기 클래스로 바꾸시오..
////		log.info("==== json ==== : 유저이름? : "+bc.name);
//		String accountId = bc.accountId;
//		String id = bc.id;
//		String puuid = bc.puuid;
//		System.out.println("1번 puuid값 : "+puuid);
////		String ddara = String.format("==== json ==== : 해당 검색 유저의 이름은 %s 입니다. 계정 id값은 %s 입니다", bc.name, accountId);
////		log.info(ddara);
//	
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		BufferedReader br = null;
//		
//		Summoner temp= null;
		
		//새로 고침 할 때
		if(temp == null) {
		try{         
			String SurmmonerName = userName.replaceAll(" ", "%20");
			String urlstr = "https://"+region+".api.riotgames.com/lol/summoner/v4/summoners/by-name/"+
					SurmmonerName+"?api_key="+API_KEY;
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
//			if(puuid_a.equals(puuid)) {
//				System.out.println("두 값이 같음");
//			} else {
//				System.out.println("아예 두값이 틀림");
//			}
//			System.out.println("2번 puuid값 : " + puuid_a);
			Double profileIconId = k.get("profileIconId").getAsDouble();
			int profileIconId_int = (int)Math.ceil((double) profileIconId);
//			log.info("==== json ==== : 해당 유저 아이콘 번호 무엇인가요? : "+profileIconId_int);

			Double summonerLevel_a = k.get("summonerLevel").getAsDouble();
			Double revisionDate_a = k.get("revisionDate").getAsDouble();
			String id_a = k.get("id").getAsString();
			String accountId_a = k.get("accountId").getAsString();

			temp = new Summoner(profileIconId_int,name_a,puuid_a,summonerLevel_a,revisionDate_a,id_a,accountId_a);
			
//			String ddaratest = String.format("==== json ==== : 소환사의 프로필사진 코드는 %s이고, 이름은 %s, 공용id는 %s, 레벨은 %s,"
//					+ " 리비젼데이트는 %s이며, 아이디는 %s, 계정 고유 아이디는 %s입니다 ", 
//					profileIconId, bc.name, puuid_a, summonerLevel_a, revisionDate_a, id_a,accountId_a);
//			log.info(ddaratest);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		System.out.println("현재 Id의 값은? : " + temp.getId());
		String INFO_API_URL = "https://"+region+".api.riotgames.com/lol/league/v4/entries/by-summoner/"
				+ temp.getId()
				+ "?api_key=" + API_KEY; 
		
//				* 주의 * https 아님 http 임. https 는 인증관련 복잡한 처리를 해야함.	
		
		//// **** 중요 **** uri			
		URI lol_uri = null; //java.net.URI 임포트 하셈			
		try {			
			lol_uri = new URI(INFO_API_URL);		
		} catch (URISyntaxException e) {			
			e.printStackTrace();		
		}	
		
//		String b = restTemplate.getForObject(lol_uri, String.class); //
	///	log.info("====== 유저 정보 잘 나오나?? "+b);
		
		LoginInfoVo LoginInfoVo = null;
		String tier = "";
		String rank = "";
		String queueType ="";
		Integer leaguePoints = 0;
		Integer wins = 0;
		Integer losses = 0;
		List<Map<String, Object>> lolbc = restTemplate.getForObject(lol_uri, List.class); // 자기 클래스로 바꾸시오..
	//	log.info("==== json ==== : 해당 유저 티어는? : "+lolbc.get(0).get("tier"));

		if(lolbc.size()==0) {
			queueType ="no search";
			 tier = "Unranked";
			 rank = "no search";
			 wins = 0;
			 losses = 0;
			 
		} else {
			String rankStr = (String)lolbc.get(0).get("tier");
				if(rankStr.equals("CHALLENGER") || rankStr.equals("GRANDMASTER")||rankStr.equals("MASTER")) { 
					queueType = (String)lolbc.get(0).get("queueType");
					 tier = (String)lolbc.get(0).get("tier");
					 rank = "";
					 leaguePoints = (Integer)lolbc.get(0).get("leaguePoints");
					 wins = (Integer)lolbc.get(0).get("wins");
					 losses = (Integer)lolbc.get(0).get("losses");
				}else {
					queueType = (String)lolbc.get(0).get("queueType");
					 tier = (String)lolbc.get(0).get("tier");
					 rank = (String)lolbc.get(0).get("rank");
					 leaguePoints = (Integer)lolbc.get(0).get("leaguePoints");
					 wins = (Integer)lolbc.get(0).get("wins");
					 losses = (Integer)lolbc.get(0).get("losses");
		}
		}
		switch(rank) {
		case"I": 
			rank="1";
			break;
			
		case"II": 
			rank="2";
			break;
			
		case"III": 
			rank="3";
			break;
			
		case"IV": 
			rank="4";
			break;
		default:
			rank="";
			break;
		}
    	
//		System.out.println("자료형 확인:"+lolbc.get(0).get("leaguePoints").getClass().getName());
//		log.info("==== json ==== : 해당 유저 리그포인트는? : "+leaguePoints);
//		System.out.println("자료형 확인:"+lolbc.get(0).get("wins").getClass().getName());
//		System.out.println("자료형 확인:"+lolbc.get(0).get("losses").getClass().getName());
		
		int winlose = wins+losses;
//		double rate = (double)(wins%(wins+losses));
		double winper_rate = ((double)((double)wins/((double)wins+(double)losses)))*100;
		String winper = String.format("%.2f", winper_rate);
//		log.info("========승률" + winper);
//		String ddaralol = String.format("==== json ==== : 본 통계는 %s를 기반으로 만들어졌습니다"
//				+ "해당 유저의 티어는 %s이며, 랭크는%s , %s번 이겼고, %s번 져서 리그포인트는 %s점 입니다", queueType, tier, rank
//				,wins, losses, leaguePoints);
//		log.info(ddaralol);
		LoginInfoVo = new LoginInfoVo(queueType, tier, rank, leaguePoints, wins, losses, winper, region);
//		log.info("==== json ==== : 해당 유저 랭크는? : "+rank);


		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//나중에 카운트 20으로 바꾸기
			
			int endNum = 9;
			int countNum = 0;
			int rankGames = 0;
			String urlstr1 ="";
			if(region.equals("na1")) {
				urlstr1 = "https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/"
						+ temp.getPuuid()
						+ "/ids?start=0&count="+endNum+"&api_key="+API_KEY;
			} else {
				urlstr1 = "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/"
					+ temp.getPuuid()
					+ "/ids?start=0&count="+endNum+"&api_key="+API_KEY;
			}
			
			
			countNum = endNum + 1;
			System.out.println("현재 countNum 값 : "+countNum);
			URI gr_uri = null; //java.net.URI 임포트 하셈			
			try {			
				gr_uri = new URI(urlstr1);		
			} catch (URISyntaxException e) {			
				e.printStackTrace();		
			}	
			List<String> grbc = restTemplate.getForObject(gr_uri, List.class); 
			String grbc1 = (String)grbc.get(0);
//			System.out.println(grbc1);
			
		//플레이어 데이터 수집
		ArrayList<Lol_api> xx = new ArrayList<Lol_api>();
		Map<String, GradeInfo> cg = new HashMap<>();// 챔피언당 게임 수 승패휫수 한번에 구하기
		GradeInfo mg = new GradeInfo(0,0,0,"","","","","","", 0.0);// 챔피언당 게임 수 승패휫수 한번에 구하기
		Map<String, Positions> positions = new HashMap<>();
		
		Integer mainKills = 0;	
		Integer mainAsis = 0;	
		Integer mainDeaths = 0;	
		Integer totalkills = 0;
		Integer utotalkills = 0;
		String gameMode = "";
		for(String matid : grbc) {
			// 아래 해당 사항들 배열로 만드어야함
			String TEST_URL ="";
			if(region.equals("na1")) {
				TEST_URL = "https://americas.api.riotgames.com/lol/match/v5/matches/"
						+ matid
						+"?api_key="+API_KEY; 
			} else {
				TEST_URL = "https://asia.api.riotgames.com/lol/match/v5/matches/"
						+ matid
						+"?api_key="+API_KEY; 
			}
			
			URI test_uri = null;
			try {			
				test_uri = new URI(TEST_URL);		
			} catch (URISyntaxException e) {			
				e.printStackTrace();		
			}	
			Cat testbc = restTemplate.getForObject(test_uri, Cat.class); // 자기 클래스로 바꾸시오..
//			String dataVersion = (String)testbc.metadata.dataVersion;
//			log.info("==== json ==== : 데이타 버전 값은?? : "+dataVersion);
//	//		List<String> players = (List<String>)testbc.metadata.participants;
//			String championName = (String)testbc.info.participants.get(0).championName;
//			log.info("==== json ==== 챔피언 이름 : "+championName);
//			String gameType = (String)testbc.info.gameType;
//			log.info("==== json ==== 게임 타입 : "+gameMode);
//			String item0 = testbc.info.participants.get(0).item0;
//			log.info("==== json ==== 아이템 고윳값 번호 : "+item0);
			//위는 거의 확인용
			String gameModeEn = (String)testbc.info.gameMode;
			Integer queueId = (Integer)testbc.info.queueId;
			if(queueId==420) {//switch로 해도됨
				gameMode = "솔랭";
			} else if(queueId==430) {
				gameMode = "일반";
			} else if(queueId==450) {
				gameMode = "무작위 총력전";
			} else if(queueId==1700) {
				gameMode = "아레나";
			} else if(queueId==1300) {
				gameMode = "돌격!넥서스";
			}	else {
			
				gameMode = queueId+"";
			}
			
			Integer gameDuration = (Integer)testbc.info.gameDuration;
			Integer timemin = gameDuration/60;
			Integer timesec = gameDuration%60;
//			System.out.println(timemin+"분 " +timesec+"초");
			
			//각 수치에 대한 객체 선언 - 꼭 괄호 바깥에서 선언*
			ArrayList<Lol_api> di = new ArrayList<Lol_api>();
			List<Participants> player_info = (List<Participants>)testbc.info.participants;// 게임데이타 받아오기
			Participants mainUser = null;
			Participants perPlayer = null;
			String aver = "";
			String perAverStr ="";
			double perAver = 0.0;
			Integer cs = 0; 
			String spellId1 = null;
			String spellId2 = null;
			String perspell1= null;
			String perspell2= null;
//			Map<String, Integer> grade = new HashMap<>();
//			GradeInfo chankey = cg.get(mainUser.championName); 
			
			for(int i=0; i<player_info.size(); i++) {
				perPlayer = player_info.get(i);//각각 플레이어
				perspell1= dInfo.getSpellName(perPlayer.summoner1Id);
				perspell2= dInfo.getSpellName(perPlayer.summoner2Id);
				perAverStr = String.format("%.2f", 
						((double)player_info.get(i).kills+(double)player_info.get(i).assists/(double)player_info.get(i).deaths)
						);
				perAver = Double.parseDouble(perAverStr);
				Lol_api yy=new Lol_api(perPlayer, perAver, perspell1, perspell2, 0.0, 0.0);
				di.add(yy);
				
				if(player_info.get(i).puuid.equals(temp.getPuuid())) {//메인 플레이어
					mainUser = player_info.get(i);
					
					utotalkills += mainUser.assists + mainUser.kills;
					
					//해당유저 모든 챔피언 평점(kda와 숭패 휫수)
					mainKills =mainKills+ mainUser.kills;
					mainAsis =mainAsis+ mainUser.assists;
					mainDeaths =mainDeaths+ mainUser.deaths;
					if(mainUser.win==true) {
						mg.chamWins = mg.chamWins + 1;
					} else {
						mg.chamLosses = mg.chamLosses + 1;
					}
					
					//cs
					cs = mainUser.totalMinionsKilled + mainUser.totalEnemyJungleMinionsKilled;
					//평점
					aver = String.format("%.2f", 
							((double)((double)mainUser.kills+(double)mainUser.assists)/(double)mainUser.deaths)
							);
					
					//최근 플레이한 챔피언 평점 or 최근 플레이한 챔피언
//					cg.put(mainUser.championName, cg.getOrDefault(mainUser.championName, 0) + 1);
					
				
					
					
					if(cg.get(mainUser.championName) == null) {
//						System.out.println("해당 챔피언 테이블이 없어서 한번 만들음");
						cg.put(mainUser.championName, new GradeInfo(
								mainUser.championName, 
								0, 
								0, 
								1, 
								0, 
								0,
								0.0,
								""
								));
						cg.get(mainUser.championName).killsAndais =cg.get(mainUser.championName).killsAndais + mainUser.kills + mainUser.assists;
						cg.get(mainUser.championName).deaths =cg.get(mainUser.championName).deaths + mainUser.deaths;
						if(mainUser.win == true) {
							cg.get(mainUser.championName).chamWins =cg.get(mainUser.championName).chamWins + 1;
//							System.out.println("누적 승리수" + mainUser.championName+ " : " + cg.get(mainUser.championName).chamWins);
						} else {
							cg.get(mainUser.championName).chamLosses =cg.get(mainUser.championName).chamLosses + 1;
//							System.out.println("누적 패배수" + mainUser.championName+ " : " + cg.get(mainUser.championName).chamLosses);
						}
					} 
						cg.get(mainUser.championName).chamGames =cg.get(mainUser.championName).chamGames + 1;
//						System.out.println("누적 판수" + mainUser.championName+ " : " + cg.get(mainUser.championName).chamGames);
						cg.get(mainUser.championName).killsAndais =cg.get(mainUser.championName).killsAndais + (mainUser.kills+mainUser.assists);
						cg.get(mainUser.championName).deaths =cg.get(mainUser.championName).deaths + mainUser.deaths;
//						if(aver.equals("Infinity")) {
//							break;
//						} else {
//							averValue = Double.parseDouble(aver);
//							cg.get(mainUser.championName).grade =+ averValue;
//						}
//						
//						System.out.println("이번 평점은 : " + cg.get(mainUser.championName).grade);
						if(mainUser.win == true) {
							cg.get(mainUser.championName).chamWins =cg.get(mainUser.championName).chamWins + 1;
//							System.out.println("누적 승리수" + mainUser.championName+ " : " + cg.get(mainUser.championName).chamWins);
						} else {
							cg.get(mainUser.championName).chamLosses =cg.get(mainUser.championName).chamLosses + 1;
//							System.out.println("누적 패배수" + mainUser.championName+ " : " + cg.get(mainUser.championName).chamLosses);
						}
					
//					cg.put(mainUser.championName, cg.get(0).(mainUser.championName, 0) + 1);
					//포지션별 횟수 구하기
					if(gameMode.equals("솔랭")) {
						rankGames += 1;
//						System.out.println("현 게임에 포지션은?" + mainUser.individualPosition);
						if(positions.get(mainUser.individualPosition) == null) {
//							System.out.println("포지션 테이블이 없어서 한번 만들음");
							positions.put(mainUser.individualPosition, new Positions(
									mainUser.individualPosition,
									0
									));
							positions.get(mainUser.individualPosition).times = positions.get(mainUser.individualPosition).times + 1;
//						System.out.println("테이블 하나 만들고 감");
						} else {
							positions.get(mainUser.individualPosition).times = positions.get(mainUser.individualPosition).times + 1;
//							System.out.println("안만들고 감");
						}
						
						}
					
					
					
					System.out.println("=============== 경계선 ===============");
					
						
//				System.out.println("이 값이 나오냐 안나오냐 : "+aver);
				}
//				System.out.println("각 챔피언당 가한 데미지는 " +player_info.get(i).totalDamageDealtToChampions+"이고, 받은 데미지는"+player_info.get(i).totalDamageTaken+"이다");
			}
			
			//가한 데미지 그래프 기준 정하고, 게이지 만들기
			int maxDealt = 0;
			String dealtStr= "";
			int maxTaken = 0;
			String takenStr= "";
			for(Lol_api p : di) {
				if(p.getMainUser().totalDamageDealtToChampions>maxDealt) {
					maxDealt = p.getMainUser().totalDamageDealtToChampions;
				}
				
				if(p.getMainUser().totalDamageTaken>maxTaken) {
					maxTaken = p.getMainUser().totalDamageTaken;
				}
				
			}
//			System.out.println("di 사이즈는? : "+ di.size());
			for(int i=0; i < di.size(); i++) {
				dealtStr = String.format("%.4f",
						((double)di.get(i).mainUser.totalDamageDealtToChampions/(double)maxDealt)*100
						 );
				
				takenStr = String.format("%.4f",
						((double)di.get(i).mainUser.totalDamageTaken/(double)maxTaken)*100
						);
				
				di.get(i).dealtPer = Double.parseDouble(dealtStr);
				di.get(i).takenPer = Double.parseDouble(takenStr);
				
//				System.out.println("해당 유저의 딜 그래프수치는 "+di.get(i).dealtPer+"이고, 받은 데미지는 "+di.get(i).takenPer+"이다");
			}
			
			
			
			
			//도합 킬수 구하기
			for(int i=0; i<player_info.size(); i++) {
				if(player_info.get(i).win==mainUser.win) { 
					totalkills += player_info.get(i).kills;
					
				}
			}
			
			//킬 관여율
//			System.out.println("전체 킬 수는 : "+totalkills_ais);
			String killsRate = String.format("%.0f",((double)(((double)mainUser.assists + (double)mainUser.kills)/(double)totalkills))*100);
//			System.out.println("킬 관여율은 : "+killsRate);
			
			//스펠 체크	
			try{            
				String urlstr = "https://ddragon.leagueoflegends.com/cdn/11.3.1/data/en_US/summoner.json";
				URL url = new URL(urlstr);
				HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
				urlconnection.setRequestMethod("GET");
				br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8")); // 여기에 문자열을 받아와라.
				String result = "";
				String line;
				while((line = br.readLine()) != null) { // 그 받아온 문자열을 계속 br에서 줄단위로 받고 출력하겠다.
					result = result + line;
				}
				JsonParser parser = new JsonParser();
				JsonObject jsonObject = parser.parse(result).getAsJsonObject();

		        // 찾고자 하는 "key" 값
		        String spell1 = mainUser.summoner1Id; // 예를 들어 "1"이라고 가정합니다.
		        String spell2 = mainUser.summoner2Id; // 예를 들어 "1"이라고 가정합니다.

		        // "data" 객체 내에서 "key" 속성이 일치하는 객체를 찾고 "id" 값을 추출
		        
		        JsonObject dataObject = jsonObject.getAsJsonObject("data");

		        for (String key : dataObject.keySet()) {
		            if (dataObject.has(key)) {
		                JsonObject innerObject = dataObject.getAsJsonObject(key);
		                String innerKey = innerObject.get("key").getAsString();

		                if (innerKey.equals(spell1)) {
		                    spellId1 = innerObject.get("id").getAsString();
		                    break; // 일치하는 "key"를 찾으면 루프를 종료합니다.
		                }
		            }
		        }
		        
		        for (String key : dataObject.keySet()) {
		        	if (dataObject.has(key)) {
		        		JsonObject innerObject = dataObject.getAsJsonObject(key);
		        		String innerKey = innerObject.get("key").getAsString();
		        		
		        		if (innerKey.equals(spell2)) {
		        			spellId2 = innerObject.get("id").getAsString();
		        			break; // 일치하는 "key"를 찾으면 루프를 종료합니다.
		        		}
		        	}
		        }

//		        if (spellId1 != null) {
//		            System.out.println("key이 " + spell1 + "에 대한 id 값: " + spellId1);
//		        } else {
//		            System.out.println("일치하는 key를 찾을 수 없습니다.");
//		        }
//		        
//		        if (spellId2 != null) {
//		        	System.out.println("key이 " + spell2 + "에 대한 id 값: " + spellId2);
//		        } else {
//		        	System.out.println("일치하는 key를 찾을 수 없습니다.");
//		        }
//		    
		
			
				
			}catch(Exception e){
				System.out.println(e.getMessage());
			}
			
			//퍼펙트에 대한 처리
			if(aver.equals("Infinity")) {
				aver="Perfact";
			}
			
			Lol_api l = new Lol_api(player_info, gameMode, timemin, timesec, mainUser, aver, killsRate, cs, spellId1, spellId2, di);
			xx.add(l);
			
//			System.out.println("4번째 아이템 고유 번호 "+ mainUser.item3);
//			String playeritem= player_info.get(2).item1;//성공적으로 받아옴
			
	//		log.info("==== json ==== 플레이어2 아이템 고윳값 번호 : "+playeritem);
	//		System.out.println("자료형 확인:"+player_info.get(6).summonerName.getClass().getName());
	//		System.out.println("자료 데이터 확인:"+player_info.get(6).summonerName);
	//		for(int i=0; i<=6; i++) {
	//			System.out.println("자료형 확인:"+testbc.info.participants.get(i).item0.getClass().getName());
	//		}
			
		}
		

//				log.info("==== json ==== 몇게임 했는지  : "+cg.get(0).chamGames);
//				log.info("==== json ==== 평점의 총합 : "+cg.get(0).grade);
	
//		log.info("==== json ==== 평점의 총합 : "+cg.get("Sylas").grade);
//		log.info("==== json ==== 몇게임 했는지 : "+cg.get("Sylas").chamGames);
//		log.info("==== json ==== 얼마나 이겼는지 : "+cg.get("Sylas").chamWins);
		
		List<GradeInfo> top3cham = new ArrayList<>();
		// 각 키에 대해 작업
        for (String key : cg.keySet()) {
            GradeInfo cham = cg.get(key);
            top3cham.add(cham); // 모든 CustomClass 객체를 목록에 추가합니다.
        }

        // 오름차순으로 정렬
        top3cham.sort((cham1, cham2) -> Integer.compare(cham2.chamGames, cham1.chamGames));

//		System.out.println("탑 1위 챔피언은 ? : " + top3cham.get(0).chamName);
//		System.out.println("탑 1위 챔피언 경기수는? : " + top3cham.get(0).chamGames);
//		System.out.println("탑 1위 챔피언 도합 킬과 어시는? : " + top3cham.get(0).killsAndais);
//		System.out.println("탑 1위 챔피언 도합 데스는? : " + top3cham.get(0).deaths);
//		System.out.println("===============================");
//		System.out.println("탑 2위 챔피언은 ? : " + top3cham.get(1).chamName);
//		System.out.println("탑 2위 챔피언 경기수는? : " + top3cham.get(1).chamGames);
//		System.out.println("탑 2위 챔피언 도합 킬과 어시는? : " + top3cham.get(1).killsAndais);
//		System.out.println("탑 2위 챔피언 도합 데스는? : " + top3cham.get(1).deaths);
//		System.out.println("===============================");
//		System.out.println("탑 3위 챔피언은 ? : " + top3cham.get(2).chamName);
//		System.out.println("탑 3위 챔피언 경기수는? : " + top3cham.get(2).chamGames);
//		System.out.println("탑 3위 챔피언 도합 킬과 어시는? : " + top3cham.get(2).killsAndais);
//		System.out.println("탑 3위 챔피언 도합 데스는? : " + top3cham.get(2).deaths);
//		System.out.println("===============================");
		String strGrade = "";
		for(int i=0; i<top3cham.size(); i++) {
			
		 strGrade = String.format("%.2f",
				 ((double)top3cham.get(i).killsAndais/(double)top3cham.get(i).deaths)
				 );
		 top3cham.get(i).grade = Double.parseDouble(strGrade);

//		 System.out.println(top3cham.get(i).chamName + " 의 평점은 : " +top3cham.get(i).grade);
		 
		 if(top3cham.get(i).chamWins==0) {
			 top3cham.get(i).winRate = "0"; 
		 }else if(top3cham.get(i).chamLosses==0) {
			 top3cham.get(i).winRate = "100"; 
		 } else {
			 top3cham.get(i).winRate = String.format("%.0f",
					 ((double)(top3cham.get(i).chamWins)/(double)(top3cham.get(i).chamWins+top3cham.get(i).chamLosses))*100
					 );
//			 System.out.println(top3cham.get(i).chamName + " 의 승률은 : " +top3cham.get(i).winRate);
		 	}
		 
		}
		
	// 포지션 쌓인걸 바탕으로 List<>생성	
//		List<Integer> positionN = new ArrayList<>();
//		for(int i=0; i<5; i++) {
//			positionN.add(i, 0);
//		}
		List<Positions> positionN = new ArrayList<>();
		positionN.add(new Positions("TOP", ""));
		positionN.add(new Positions("JUNGLE", ""));
		positionN.add(new Positions("MIDDLE", ""));
		positionN.add(new Positions("BOTTOM", ""));
		positionN.add(new Positions("SURPORT", ""));
		System.out.println("포지션 리스트 사이즈는? : " +positionN.size());
		// 포지션 키값 리스트에 옮기기
        for (String key : positions.keySet()) {
//        	System.out.println("각각 " + positions.get(key).position+ "이 있음");
        	for(int i = 0; i<positionN.size(); i++) {
        		if(key.equals(positionN.get(i).position)) {
        			if(positions.get(key).times!=0) {
//        				System.out.println("현재 rankGames 값 : "+rankGames);
        			positionN.get(i).gauge = String.format("%.4f",((double)positions.get(key).times/(double)rankGames)*100); 
//        			System.out.println(positionN.get(i).position+"의 포지션에 값이 들어감 : " +positionN.get(i).gauge);
        			} 
        		}
        
        	}
        	
        }
        //빈 문자열이 있는 곳 채우기
        for(int i=0; i<positionN.size(); i++) {
        	if(positionN.get(i).gauge.equals("")) {
        		positionN.get(i).gauge = "0";
        	}
//    		System.out.println("포지션 " +positionN.get(i).position+ "에 " +positionN.get(i).gauge+"의 값이 들어있음");
        }
        
        //해당유저 평균 게임 정보
        String winCircleStr = "";
        mg.chamGames = mg.chamWins + mg.chamLosses;
//        System.out.println("총 게임수 : " +mg.chamGames+"번, 도합 킬 수 : "+mainKills+ "번, 도합 데스 수 : "+mainDeaths+ "번, 도합 어시 수 : "+mainAsis+"번");
        mg.killGrade = String.format("%.1f",(double)mainKills/(double)(mg.chamWins+mg.chamLosses));
        mg.asiGrade = String.format("%.1f",(double)mainAsis/(double)(mg.chamWins+mg.chamLosses));
        mg.deathGrade = String.format("%.1f",(double)mainDeaths/(double)(mg.chamWins+mg.chamLosses));
        mg.gradestr = String.format("%.2f",(double)(mainKills+ mainAsis)/(double)mainDeaths);
        mg.winRate = String.format("%.0f",((double)mg.chamWins/(double)mg.chamGames)*100);
        mg.killRate = String.format("%.0f",((double)utotalkills/(double)totalkills)*100);
        winCircleStr = String.format("%.3f",(Double.parseDouble(mg.winRate)/100.0)*360);
        mg.winCircle = Double.parseDouble(winCircleStr);
        
        GameInfo gg = new GameInfo(mg, endNum); // 게임 기본 정보 넘기기
        
//        // 각 키에 대해 작업
//        for (String key : positions.keySet()) {
//        	System.out.println("각각 " + positions.get(key).position+ "이 있음");
//        	for(int i = 0; i<positionN.size(); i++) {
//        		if(key.equals(positionN.get(i).position)) {
//        			positionN.get(i).times = positions.get(key).times;
//        			System.out.println(positionN.get(i).position+"의 포지션에 값이 들어감 : " +positionN.get(i).times);
//        		}
//        	}
//        	
//        }
//        
        
        //포지션 값 확인
//        for(int i=0; i< positionN.size(); i++) {
//        	System.out.println("리스트에 " + positionN.get(i).position+ "을 "+positionN.get(i).times+"번 씩함");
//        }
		
//		System.out.println("xx 사이즈 : " + xx.size());
//		System.out.println("값 잘나오나 >? : "+ xx.get(0).getParticipants().get(0).item0);
//		System.out.println("1경기 5번째 플레이어 네임 >? : "+ xx.get(0).getParticipants().get(5).summonerName);
		
//		for(String participants : players){
//			
//			log.info("==== json ==== 플레이어 id 값 : "+participants);
//		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// match 정보 받아오기 
		
	
		
		

		
	
		log.info("===================통과선=====================");

		
 		model.addAttribute("gameInfo", gg);
 		model.addAttribute("positions", positionN);
 		model.addAttribute("summoner", temp);
 		model.addAttribute("top3cham", top3cham);
 		model.addAttribute("liv", LoginInfoVo);
 		model.addAttribute("L_Api", xx);
		model.addAttribute("profile_img", "http://ddragon.leagueoflegends.com/cdn/13.18.1/img/profileicon/"+temp.getProfileIconId()+".png");
	
		
		
		
		
        
		
		
	
	
	}
	
	}
