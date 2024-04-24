package kr.kh.team4.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.service.MemberService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class MailController {
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/mail")
	public String mail(Model model) {
		model.addAttribute("title", "문자 테스트");
		return "/mail";
	}
	
	@ResponseBody
	@PostMapping("/mail")
	public String mail(String[] args, @RequestParam("phone")String phone, @RequestParam("content")String content) {
	    String api_key = "NCSJAUZLM1DHEWEW";
	    String api_secret = "RM7CHJOAGAI3S9CBNC92JDBHOPO8LTFV";
	    Message coolsms = new Message(api_key, api_secret);
	    
	    
	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone);	// 수신전화번호
	    params.put("from", "01050602154");	// 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");	// 타입
	    params.put("text", content); //내용
	    params.put("app_version", "test app 1.2"); // application name and version
	
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
	    return "/main/home";
    }
	
	@ResponseBody
	@PostMapping("/mail/send")
	public HashMap<String, String> bookCheck(String[] args, @RequestParam("phone")String phone, @RequestParam("content")String content) {
		String api_key = "NCSJAUZLM1DHEWEW";
	    String api_secret = "RM7CHJOAGAI3S9CBNC92JDBHOPO8LTFV";
	    Message coolsms = new Message(api_key, api_secret);
	    
	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone);	// 수신전화번호
	    params.put("from", "01050602154");	// 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");	// 타입
	    params.put("text", content); //내용
	    params.put("app_version", "test app 1.2"); // application name and version
	
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
		return params;
	}
}
