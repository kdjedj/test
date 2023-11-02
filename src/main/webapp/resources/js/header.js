$(document).ready(function() {
  const mainTabs = $('.main-tab ul li');
  const subTabs = $('.sub-tab');
  
  // 상단탭 클릭시 해당탭&하단탭 색상변경
  mainTabs.on('click', function() {
    // 모든 main-tab의 li 배경색 초기화
    mainTabs.css('background-color', 'initial');

    // 선택한 main-tab의 li 배경색 변경
    $(this).css('background-color', '#5553b7');

    // 선택한 main-tab에 연결된 sub-tab 색상 변경
    subTabs.css('background-color', '#5553b7');

    // 모든 main-tab의 span 스타일 초기화
    mainTabs.find('span').css('font-weight', 'normal');

    // 선택한 main-tab의 span 스타일 변경
    $(this).find('span').css('font-weight', 'bold');
  });
});