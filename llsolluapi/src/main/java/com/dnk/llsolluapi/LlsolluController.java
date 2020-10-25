package com.dnk.llsolluapi;

import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dnk.llsolluapi.dto.LlsolluDto;
import com.dnk.llsolluapi.service.llsolluService;


@Controller
public class LlsolluController {
	
	private static final Logger logger = LoggerFactory.getLogger(LlsolluController.class);
	
	@Autowired
	llsolluService llsolluService;
	
	@RequestMapping("/llsollu")
	public String goLlusollu() {
		String address = "dnk/llsolluTest";
		return address;
	}
	
	@RequestMapping("/contensTest")
	public String goContensTest() {
		String address = "dnk/llsolluTest2";
		return address;
	}
	
	@RequestMapping(value="/llsolluChina", produces ="application/text; charset=utf8")
	@ResponseBody
	public String Translation(@RequestParam(value = "korean", defaultValue = "-")String korean,
			Model model) {
		LlsolluDto ld = new LlsolluDto();
		String apikey = "734ac34d-5577-452f-8fed-56cd96f54c19";
		String target = "zh";
		korean =URLEncoder.encode(korean);
		ld.setKorean(korean);
		ld.setApikey(apikey);
		ld.setTarget(target);
		String china = llsolluService.getllsolluTranslation(ld);
		return china;
	}
	
	@RequestMapping("/llsolluEnglish")
	@ResponseBody
	public String Translation2(@RequestParam(value = "korean", defaultValue = "-")String korean,
			Model model) {
		LlsolluDto ld = new LlsolluDto();
		String apikey = "734ac34d-5577-452f-8fed-56cd96f54c19";
		String target = "en";
		korean =URLEncoder.encode(korean);
		ld.setKorean(korean);
		ld.setApikey(apikey);
		ld.setTarget(target);
		String china = llsolluService.getllsolluTranslation(ld);
		return china;
	}
	
	@RequestMapping(value="/contensChina", produces ="application/text; charset=utf8")
	@ResponseBody
	public String Translation3(@RequestParam(value = "english", defaultValue = "-")String english,
			Model model) {
		LlsolluDto ld = new LlsolluDto();
		String apikey = "734ac34d-5577-452f-8fed-56cd96f54c19";
		String target = "zh";
		ld.setKorean(english);
		ld.setApikey(apikey);
		ld.setTarget(target);
		String china = llsolluService.getllsolluTranslate(ld);
		return china;
	}
	
	@RequestMapping(value="/contensKorean", produces ="application/text; charset=utf8")
	@ResponseBody
	public String Translation4(@RequestParam(value = "english", defaultValue = "-")String english,
			Model model) {
		LlsolluDto ld = new LlsolluDto();
		String apikey = "734ac34d-5577-452f-8fed-56cd96f54c19";
		String target = "ko";
		ld.setKorean(english);
		ld.setApikey(apikey);
		ld.setTarget(target);
		String korean = llsolluService.getllsolluTranslate(ld);
		//logger.info(">>>>>>>>"+korean);
		return korean;
	}

	
}
