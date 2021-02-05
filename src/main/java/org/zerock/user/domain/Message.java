package org.zerock.user.domain;

import java.util.HashMap;

import org.json.simple.JSONObject;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Message {

	public Message(String api_key, String api_secret) {
		// TODO Auto-generated constructor stub
	}

	public JSONObject send(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return null;
	}

}
