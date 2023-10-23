package com.peisia.spring.spb.lol;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)

public class Metadata {
	public String dataVersion;
	public String matchId;
	public List<String> participants;
}
