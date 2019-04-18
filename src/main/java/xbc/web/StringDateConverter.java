package xbc.web;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

public class StringDateConverter implements Converter<String, Date> {

	@Override
	public Date convert(String source) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		try {
			return sdf.parse(source);
		} catch (Exception e) {
			return null;
		}
	}
}