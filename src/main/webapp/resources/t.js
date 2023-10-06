//main-tab 의 li 마우스 클릭시 해당 탭과 서브탭 색상변경.(다른 카테고리 생기면 서브탭 바꿔주기 추가해야함)(이렇게 하려면 기본 색상 변경해둬야함)
document.addEventListener("DOMContentLoaded", function () { //돔 요소 조작을 페이지 로드 완료이후에 시작
  const mainTabs = document.querySelectorAll('.main-tab ul li');
  const subTabs = document.querySelectorAll('.sub-tab');

  mainTabs.forEach((tab, index) => {
    tab.addEventListener('click', () => {
      console.log('클릭 이벤트 발생!'); // 디버깅용 로그
		mainTabs.forEach((mainTab) => {
            mainTab.style.backgroundColor = 'initial'; // li의 배경색 초기화
        });
    	tab.style.backgroundColor = '#5553b7'; // 선택한 main-tab의 li 배경색 변경	  
      // 선택한 main-tab에 연결된 sub-tab 색상 변경
      subTabs.forEach((subTab) => {
        subTab.style.backgroundColor = '#5553b7';
      });

      // 모든 main-tab의 span 스타일 초기화
      mainTabs.forEach((mainTab) => {
        mainTab.querySelector('span').style.fontWeight = 'normal'; // 원래 스타일로 초기화
      });

      // 선택한 main-tab의 span 스타일 변경
      tab.querySelector('span').style.fontWeight = 'bold';
    });
  });
});