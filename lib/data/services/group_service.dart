import 'dart:convert';
import 'package:http/http.dart' as http;

class GroupService {
  // 에뮬레이터에서 실행할 때는 localhost 대신 10.0.2.2를 씁니다.
  final String baseUrl = "http://10.0.2.2:8080/api/groups";

  // # 1. 그룹을 만들고 초대코드를 받아오는 함수
  Future<String> createGroupAndGetCode(String name) async {
    try {
      // 1. 주소 만들기 (예: http://.../groups?name=우리집가계부)
      final url = Uri.parse('$baseUrl?name=$name');

      // 2. 백엔드에 POST 요청 보내기
      final response = await http.post(url);

      // 3. 성공(200)했는지 확인하고 데이터 꺼내기
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data['inviteCode']; // 여기서 "22F34B" 같은 코드가 나옵니다!
      } else {
        return "오류 발생: ${response.statusCode}";
      }
    } catch (e) {
      return "연결 실패: $e";
    }
  }

  // # 2. 그룹 참여
  Future<bool> joinGroup(String userId, String inviteCode) async {
    try {
      // 명세서에 맞춘 최종 URL 생성
      final url = Uri.parse('$baseUrl/join?userId=$userId&inviteCode=$inviteCode');

      print("서버 요청 중: $url");

      final response = await http.post(url).timeout(const Duration(seconds: 5));

      print("서버 응답 코드: ${response.statusCode}");
      print("서버 응답 내용: ${response.body}");

      // 200번대 응답이면 성공으로 간주
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      print("통신 중 에러 발생: $e");
      return false;
    }
  }
}