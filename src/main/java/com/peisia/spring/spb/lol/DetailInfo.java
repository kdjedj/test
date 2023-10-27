package com.peisia.spring.spb.lol;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;



public class DetailInfo {
	
		
	public String getSpellName(String spellId) {
		BufferedReader br = null;
		String spellName = "";
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
	        String spell1 = spellId; // 예를 들어 "1"이라고 가정합니다.

	        // "data" 객체 내에서 "key" 속성이 일치하는 객체를 찾고 "id" 값을 추출
	        
	        JsonObject dataObject = jsonObject.getAsJsonObject("data");

	        for (String key : dataObject.keySet()) {
	            if (dataObject.has(key)) {
	                JsonObject innerObject = dataObject.getAsJsonObject(key);
	                String innerKey = innerObject.get("key").getAsString();

	                if (innerKey.equals(spell1)) {
	                    spellName = innerObject.get("id").getAsString();
	                    break; // 일치하는 "key"를 찾으면 루프를 종료합니다.
	                }
	            }
	        }
		 }catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		
		return spellName;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
