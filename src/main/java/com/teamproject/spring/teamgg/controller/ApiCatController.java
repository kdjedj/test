package com.teamproject.spring.teamgg.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.spring.teamgg.vo.Cat;
import com.teamproject.spring.teamgg.vo.Dog;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/api/*")
@RestController
public class ApiCatController {
		
	@GetMapping("/catOne")	
	public Cat getCatOne() {	
		Cat cat = new Cat();
		cat.setName("야옹이");
		cat.setAge(5);
		return cat;
	}	
	@GetMapping("/catTwo")	
	public Cat getCatTwo(@RequestParam("a") String c) {
		log.info("==== 보낸거 잘 받았음:"+c);
		Cat cat = new Cat();
		cat.setName("떼껄룩");
		cat.setAge(10);
		return cat;
	}	
	@GetMapping("/dog")	
	public Dog dog() {	
		Dog dog = new Dog();
		dog.name="두리";
		dog.age=10;
		return dog;
	}	
}
