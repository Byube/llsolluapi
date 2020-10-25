package com.dnk.llsolluapi.service;

import java.nio.charset.StandardCharsets;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

import com.dnk.llsolluapi.dto.LlsolluDto;

@Service
public class llsolluServiceImpl implements llsolluService {

	@Override
	public String getllsolluTranslation(LlsolluDto ld) {
		String reqURL = "https://api.llsollu.com/v1/translation/text/translate?api-key=" + ld.getApikey() + "&input="
				+ ld.getKorean() + "&source=ko&target=" + ld.getTarget();
		String result = "";
		CloseableHttpClient httpClient = HttpClients.createDefault();
		try {
			HttpGet request = new HttpGet(reqURL);
			CloseableHttpResponse response = httpClient.execute(request);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, "UTF-8");
			response.close();
			httpClient.close();
		} catch (Exception e) {
			result = e.getMessage();
			
		}
		return result;
	}

	@Override
	public String getllsolluTranslate(LlsolluDto ld) {
		String reqURL = "https://api.llsollu.com/v1/translation/text/translate?api-key=" + ld.getApikey()
				+ "&source=en&target=" + ld.getTarget();
		String result = "";
		try {
			HttpPost post = new HttpPost(reqURL);
			post.addHeader("Content-Type", "text/plain; charset=UTF-8");
			post.addHeader("accept", "application/json");
			post.setEntity(new StringEntity(ld.getKorean(), "UTF-8"));
			CloseableHttpClient httpClient = HttpClients.createDefault();
			CloseableHttpResponse response = httpClient.execute(post);
			result = EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8);
			response.close();
			httpClient.close();
		} catch (Exception e) {
			result += e.getMessage();
		}
		return result;
	}

}
