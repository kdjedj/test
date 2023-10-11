package com.teamproject.spring.teamgg.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.peisia.spring.spb.lol.Cat;
import com.peisia.spring.spb.lol.GradeInfo;
import com.peisia.spring.spb.lol.LoginInfoVo;
import com.peisia.spring.spb.lol.Lol_api;
import com.peisia.spring.spb.lol.Participants;
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
		String SurmmonerName = userName.replaceAll(" ", "%20");
		String API_KEY = "RGAPI-0092f94c-82f2-4df3-ad25-ac35254f878e";
				
//		String API_URL = "https://kr.api.riotgames.com/lol/summoner/v4"
//				+ "/summoners/by-name/"
//				+ SurmmonerName
//				+ "?api_key=" + API_KEY; 
//				
////				* 주의 * https 아님 http 임. https 는 인증관련 복잡한 처리를 해야함.	
		RestTemplate restTemplate = new RestTemplate();			
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
		BufferedReader br = null;
		
		Summoner temp= null;
		try{            
			String urlstr = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/"+
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
		
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		String INFO_API_URL = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/"
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
		List<Map<String, Object>> lolbc = restTemplate.getForObject(lol_uri, List.class); // 자기 클래스로 바꾸시오..
	//	log.info("==== json ==== : 해당 유저 티어는? : "+lolbc.get(0).get("tier"));
		String queueType = (String)lolbc.get(0).get("queueType");
    	String tier = (String)lolbc.get(0).get("tier");
		String rank = (String)lolbc.get(0).get("rank");
//		System.out.println("자료형 확인:"+lolbc.get(0).get("leaguePoints").getClass().getName());

		Integer leaguePoints = (Integer)lolbc.get(0).get("leaguePoints");
//		log.info("==== json ==== : 해당 유저 리그포인트는? : "+leaguePoints);
		
//		System.out.println("자료형 확인:"+lolbc.get(0).get("wins").getClass().getName());
		Integer wins = (Integer)lolbc.get(0).get("wins");

//		System.out.println("자료형 확인:"+lolbc.get(0).get("losses").getClass().getName());
		Integer losses = (Integer)lolbc.get(0).get("losses");
		
		int winlose = wins+losses;
		double rate = (double)(wins%(wins+losses));
		double winper_rate = ((double)((double)wins/((double)wins+(double)losses)))*100;
		String winper = String.format("%.2f", winper_rate);
//		log.info("========승률" + winper);
//		String ddaralol = String.format("==== json ==== : 본 통계는 %s를 기반으로 만들어졌습니다"
//				+ "해당 유저의 티어는 %s이며, 랭크는%s , %s번 이겼고, %s번 져서 리그포인트는 %s점 입니다", queueType, tier, rank
//				,wins, losses, leaguePoints);
//		log.info(ddaralol);
		
//		log.info("==== json ==== : 해당 유저 랭크는? : "+rank);
		LoginInfoVo = new LoginInfoVo(queueType, tier, rank, leaguePoints, wins, losses, winper);

		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//나중에 카운트 20으로 바꾸기
			
			String urlstr1 = "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/"
					+ temp.getPuuid()
					+ "/ids?start=0&count=9&api_key="+API_KEY;
			URI gr_uri = null; //java.net.URI 임포트 하셈			
			try {			
				gr_uri = new URI(urlstr1);		
			} catch (URISyntaxException e) {			
				e.printStackTrace();		
			}	
			List<String> grbc = restTemplate.getForObject(gr_uri, List.class); 
			String grbc1 = (String)grbc.get(0);
			System.out.println(grbc1);
			
		//플레이어 데이터 수집
		ArrayList<Lol_api> xx = new ArrayList<Lol_api>();
//		ArrayList<Map<String, GradeInfo>> cg = new ArrayList<>();// 게임 수 승패휫수 한번에 구하기
		Map<String, GradeInfo> cg = new HashMap<>();// 게임 수 승패휫수 한번에 구하기
//		Map<String, Integer> cg = new HashMap<>();
		for(String matid : grbc) {
			// 아래 해당 사항들 배열로 만드어야함
			String TEST_URL = "https://asia.api.riotgames.com/lol/match/v5/matches/"
					+ matid
					+"?api_key="+API_KEY; 
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
			String gameMode = (String)testbc.info.gameMode;
			
			
			//각 수치에 대한 객체 선언 - 꼭 괄호 바깥에서 선언*
			List<Participants> player_info = (List<Participants>)testbc.info.participants;// 게임데이타 받아오기
			Participants mainUser = null;
			String aver = "";
			double totalkills_ais = 0.0;
			Integer cs = 0; 
			String spellId1 = null;
			String spellId2 = null;
//			Map<String, Integer> grade = new HashMap<>();
//			GradeInfo chankey = cg.get(mainUser.championName); 
			double averValue = 0.0;
			
			for(int i=0; i<player_info.size(); i++) {
				if(player_info.get(i).win==true) { //그냥 이긴팀 킬수 누적
					totalkills_ais += (double)player_info.get(i).kills;
					
				}
				if(player_info.get(i).puuid.equals(temp.getPuuid())) {
					mainUser = player_info.get(i);
					
					//cs
					cs = mainUser.totalMinionsKilled + mainUser.totalEnemyJungleMinionsKilled;
					//평점
					aver = String.format("%.2f", 
							((double)((double)mainUser.kills+(double)mainUser.assists)/(double)mainUser.deaths)
							);
					averValue = Double.parseDouble(aver);
					//최근 플레이한 챔피언 평점 or 최근 플레이한 챔피언
//					cg.put(mainUser.championName, cg.getOrDefault(mainUser.championName, 0) + 1);
					
					if(cg.get(mainUser.championName) == null) {
						cg.put(mainUser.championName, new GradeInfo(mainUser.championName, 0.0, 0.0, 0, 0.0));
					} else {
						cg.get(mainUser.championName).chamGames =+ 1;
						cg.get(mainUser.championName).grade =+ averValue;
						if(mainUser.win == true) {
							cg.get(mainUser.championName).chamWins =+ 1.0;
						} else {
							cg.get(mainUser.championName).chamLosses =+ 1.0;
						}
					}
//					cg.put(mainUser.championName, cg.get(0).(mainUser.championName, 0) + 1);

					//spell
					
//					System.out.println("===============================");
					
						if(aver.equals("Infinity")) {
							aver="Perfact";
						}
//				System.out.println("이 값이 나오냐 안나오냐 : "+aver);
				}
			}
			//킬 관여율
//			System.out.println("전체 킬 수는 : "+totalkills_ais);
			String killsRate = String.format("%.0f",((double)(((double)mainUser.assists + (double)mainUser.kills)/totalkills_ais))*100);
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
			
			
			
			Lol_api l = new Lol_api(player_info, gameMode, mainUser, aver, killsRate, cs, spellId1, spellId2);
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
		
		
		
	       // 빈도수가 가장 높은 3챔피언 찾기
//        List<Map.Entry<String, Integer>> sortedCg = new ArrayList<>(cg.entrySet());
//        sortedCg.sort((entry1, entry2) -> entry2.getValue().compareTo(entry1.getValue()));
        
        System.out.println("가장 많이 나타나는 3가지 챔피언 :");
//        for (int i = 0; i < Math.min(3, sortedCg.size()); i++) {
//            System.out.println(sortedCg.get(i).getKey() + ": " + sortedCg.get(i).getValue() + "번 경기함");
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

		
 		model.addAttribute("summoner", temp);
 		model.addAttribute("liv", LoginInfoVo);
 		model.addAttribute("L_Api", xx);
		model.addAttribute("profile_img", "http://ddragon.leagueoflegends.com/cdn/13.18.1/img/profileicon/"+temp.getProfileIconId()+".png");
	//	model.addAttribute("Item_imgURL", "https://ddragon.leagueoflegends.com/cdn/13.18.1/img/item/"++".png");
	
		
		
		
		
        
		
		
	
	
	}
	
}
