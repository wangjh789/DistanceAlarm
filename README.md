# DistanceAlarm

Client : Flutter Application

Server : Arduino uno (+ ESP01)

## 개발 동기

편의점 알바 중 적외선 센서가 고장나서 매우 불편한데 고쳐줄 생각이 없어보임. 

초음파 거리센서를 이용해 만들어 보기로 함.

## 플로우

<img width="600" alt="스크린샷 2021-04-03 오후 6 30 11" src="https://user-images.githubusercontent.com/19744909/113474393-b6f82900-94aa-11eb-98ed-61dec16fd587.png">

## 추가
- flutter_beep 패키지 : 진동만으로 부족하다고 생각 + Error 났을 때 예외처리 => 일정거리 이하로 떨어질때 알람 발생, Client 통신에러 발생 시 경고음 발생
- screen 패키지 : 별 동작없을 시 휴대폰 홀드 상태로 돌아가는 상황 방지

## 사진

<img width="600" alt="스크린샷 2021-04-03 오후 6 30 11" src="https://user-images.githubusercontent.com/19744909/114161631-439b5f00-9963-11eb-918e-3bf8b97059bb.jpeg">



