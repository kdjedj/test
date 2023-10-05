package com.teamproject.spring.teamgg.board;
import java.text.SimpleDateFormat;
import java.util.Date;
public class TimeFormatter {
	private static class TIME_MAXIMUM {
		public static final int SEC = 60;
		public static final int MIN = 60;
		public static final int HOUR = 24;
		public static final int DAY = 30;
	}
	
	public static String calculateTime(Date date) {
		long curTimeMillis = System.currentTimeMillis();
		long regTimeMillis = date.getTime();
//		작성 시점과 현재 시간의 차이를 초 단위로 구하기
//		(밀리초 단위로 나타낸) 현재 시간 - 작성 시간 / 1000 
		long diffTimeSec = (curTimeMillis - regTimeMillis) / 1000;
		String msg = null;
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("M.d");
	    
	    if (diffTimeSec < TIME_MAXIMUM.SEC) {
	        msg = diffTimeSec + "초 전";
	    } else if ((diffTimeSec /= TIME_MAXIMUM.SEC) < TIME_MAXIMUM.MIN) {
	        msg = diffTimeSec + "분 전";
	    } else if ((diffTimeSec /= TIME_MAXIMUM.MIN) < TIME_MAXIMUM.HOUR) {
	        msg = (diffTimeSec) + "시간 전";
	    } else if ((diffTimeSec /= TIME_MAXIMUM.HOUR) < TIME_MAXIMUM.DAY) {
	        if (diffTimeSec < 3) {
	            msg = (diffTimeSec) + "일 전";
	        } else {
//	            3일 이상이면 날짜 형식으로 표시
	            msg = dateFormat.format(date);
	        }
	    } else {
	        msg = dateFormat.format(date);
	    }
	    
	    return msg;
	}
}