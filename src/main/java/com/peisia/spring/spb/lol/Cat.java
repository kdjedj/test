package com.peisia.spring.spb.lol;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Cat {
	public Metadata metadata;
	public Info info;
	
}
