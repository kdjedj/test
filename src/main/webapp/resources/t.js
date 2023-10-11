$(document).ready(function() {
  const mainTabs = $('.main-tab ul li');
  const subTabs = $('.sub-tab');
  const underBox = $('.searchbox');
  const underBar = $('.under-bar');
  const searchInput = $('#searchInput'); // 검색어 입력 필드 선택
  
  // 쿠키를 읽어와서 검색어 입력 필드에 설정
  searchInput.val(getCookie('searchHistory'));
  
  // 상단탭 클릭시 해당탭&하단탭 색상변경
  mainTabs.on('click', function() {
    console.log('클릭 이벤트 발생!'); // 디버깅용 로그
    
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

  // 검색창 클릭시 서치패널 보이게
  underBox.on('click', function(event) {
    underBar.children('.search-panel').css('display', 'block');
    event.stopPropagation();
// 검색창 클릭 시 서치패널을 열 때 검색어를 읽어온 후 설정
    var searchHistory = getCookie('searchHistory');
	if (searchHistory) {
		$('.cookies').text(searchHistory);
  	}
  });

  // 서치패널 숨기기
  $(document).on('click', function() {
    underBar.children('.search-panel').css('display', 'none');
  });

  // 쿠키를 설정하는 함수
  function setCookie(name, value, days) {
    var expires = "";
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + value + expires + "; path=/";
  }

  // 쿠키를 읽는 함수
  function getCookie(name) {
    var nameEQ = name + "=";
    var cookies = document.cookie.split(';');
    for (var i = 0; i < cookies.length; i++) {
      var cookie = cookies[i];
      while (cookie.charAt(0) === ' ') {
        cookie = cookie.substring(1, cookie.length);
      }
      if (cookie.indexOf(nameEQ) === 0) {
        return cookie.substring(nameEQ.length, cookie.length);
      }
    }
    return null;
  }

  // 검색 버튼 클릭 시 검색 페이지로 이동
  $('#searchButton').on('click', function() {
    var searchQuery = $('input[name="search"]').val();
    if (searchQuery) {
		setCookie('searchHistory', searchQuery, 30); // 쿠키에 검색어를 저장, 30은 쿠키 유효기간 (일)
    
    	var searchUrl = '/teamgg/board/searching_player?userName=' + encodeURIComponent(searchQuery);
    	window.location.href = searchUrl;
  
    }
    
  });
});
