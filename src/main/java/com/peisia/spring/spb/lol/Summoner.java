package com.peisia.spring.spb.lol;

import lombok.Data;

@Data
public class Summoner {
	    private int profileIconId;
	    private String name;
	    private String puuid;
	    private Double summonerLevel;
	    private Double revisionDate;
	    private String id;
	    private String accountId;

	    public Summoner(int profileIconId, String name, String puuid, Double summonerLevel, Double revisionDate, String id, String accountId) {
	        this.profileIconId = profileIconId;
	        this.name = name;
	        this.puuid = puuid;
	        this.summonerLevel = summonerLevel;
	        this.revisionDate = revisionDate;
	        this.id = id;
	        this.accountId = accountId;
	    }

	    // Getter 및 Setter 메서드
	    public int getProfileIconId() {
	        return profileIconId;
	    }

	    public void setProfileIconId(int profileIconId) {
	        this.profileIconId = profileIconId;
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public String getPuuid() {
	        return puuid;
	    }

	    public void setPuuid(String puuid) {
	        this.puuid = puuid;
	    }

	    public Double getSummonerLevel() {
	        return summonerLevel;
	    }

	    public void setSummonerLevel(Double summonerLevel) {
	        this.summonerLevel = summonerLevel;
	    }

	    public Double getRevisionDate() {
	        return revisionDate;
	    }

	    public void setRevisionDate(Double revisionDate) {
	        this.revisionDate = revisionDate;
	    }

	    public String getId() {
	        return id;
	    }

	    public void setId(String id) {
	        this.id = id;
	    }

	    public String getAccountId() {
	        return accountId;
	    }

	    public void setAccountId(String accountId) {
	        this.accountId = accountId;
	    }
	}

