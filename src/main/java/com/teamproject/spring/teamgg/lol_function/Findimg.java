//package com.teamproject.spring.teamgg.lol_function;
//
//import com.google.gson.JsonObject;
//
//public class Findimg {
//    public static void main(String[] args) {
////        String json = "{"hello1": {"id": "test1", "key": "1"}, "hello2": {"id": "test1", "key": "2"}}";
////        String searchKey = "1"; // 찾고자 하는 키
//
//        // JSON 문자열을 JSONObject로 파싱
//        JsonObject jsonObject = new JsonObject(json);
//
//        // JSON 객체에서 키를 찾아서 ID 값을 가져오기
//        String foundId = null;
//
//        for (String key : jsonObject.keySet()) {
//            JsonObject innerObject = jsonObject.getAsJsonObject(key);
//            String innerKey = innerObject.getAsString();
//
//            if (innerKey.equals(searchKey)) {
//                foundId = innerObject.getAsString("id");
//                break; // 키를 찾았으므로 루프 종료
//            }
//        }
//
//        if (foundId != null) {
//            System.out.println("키 " + searchKey + "에 대한 ID 값은: " + foundId);
//        } else {
//            System.out.println("키 " + searchKey + "를 찾을 수 없습니다.");
//        }
//    }
//}