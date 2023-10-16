$(document).ready(function() {
  const mainTabs = $('.main-tab ul li');
  const subTabs = $('.sub-tab');
  const underBox = $('.searchbox');
  const underBar = $('.under-bar');
  const searchInput = $('#searchInput'); // 검색어 입력 필드 선택
  var MAX_SEARCH_HISTORY = 5; // 최대 검색어 개수

  // 쿠키를 읽어와서 검색어 입력 필드에 설정
  searchInput.val(getCookie('searchHistory'));

  var selectedRegion = "kr"; // 기본 리전 설정 (kr, na, jp 등)

  // 상단탭 클릭시 해당탭&하단탭 색상변경
  mainTabs.on('click', function() {
    //console.log('클릭 이벤트 발생!'); // 디버깅용 로그

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

  // 검색창 클릭 시 서치패널 보이게
  underBox.on('click', function(event) {
    underBar.children('.search-panel').css('display', 'block');
    event.stopPropagation();
	// 리전 업데이트
    selectedRegion = $('#kr').val();
    //console.log('셀렉트리전테스트:' + selectedRegion);
    var searchHistory = getCookie('searchHistory');
    //console.log(searchHistory);
    if (searchHistory) {
      var searchList = searchHistory.split(','); // 쿠키에서 검색어 목록 가져오기
      var cookiesList = $('.cookies'); // 쿠키 목록 요소 선택
      cookiesList.empty();
      var id = 0; // 아이템 ID 초기화
      for (var i = 0; i < searchList.length; i++) {
        var searchData = searchList[i].split(':');
        var region = searchData[0]; // 리전
        var query = searchData[1]; // 검색어
        
        //console.log('리전테스트:'+searchData[0]);
        

		// 아이템을 생성하고 이벤트를 연결할 때마다 ID를 증가시킴
		var li = $('<li>' +
		  '<span class="test">' + region + '</span>' +
		  '<span class="summoner">' + query + '</span>' +
		  '<input class="hidden" type="checkbox" id="fav_' + id + '">' +
		  '<label class="favorite-summoner-label" for="fav_' + id + '"></label>' +
		  '<span class="fav-label">즐겨찾기</span>' +
		  '</li');
		  
		// 해당 체크박스와 레이블에 대한 이벤트 처리
		var checkbox = li.find('input[type="checkbox"]');
		var label = li.find('label.favorite-summoner-label');
		
		label.on('click', function() {
			// 체크박스 상태 변경
  			var checkbox = $(this).prev('input[type="checkbox"]');
    		checkbox.prop('checked', !checkbox.prop('checked'));
		});
		
		
		checkbox.on('change', function() {
		  if ($(this).is(':checked')) {
		    // 체크박스가 선택되었을 때, 노란 별로 변경
		    var label = $(this).next('label.favorite-summoner-label');
      		label.addClass('yellow-star');
		  } else {
		    // 체크박스가 선택 해제되었을 때, 빈 별로 변경
		    var label = $(this).next('label.favorite-summoner-label');
     		label.removeClass('yellow-star');
		  }
		});

		id++; // 다음 아이템을 위한 ID 증가
        li.find('.summoner').on('click', function() {
          var searchQuery = $(this).text();
          var searchUrl = '/teamgg/board/searching_player?userName=' + encodeURIComponent(searchQuery);
          window.location.href = searchUrl;
        });
        cookiesList.append(li);
      }
    }
  });

  // 서치패널 숨기기
  $(document).on('click', function() {
    underBar.children('.search-panel').css('display', 'none');
  });

  // 쿠키를 설정하는 함수 (쿠키는 쉼표로 구분하여 저장)
  function setCookie(name, value, days) {
    var expires = "";
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }
    // 쿠키 설정
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
      var searchHistory = getCookie('searchHistory');
      var searchList = searchHistory ? searchHistory.split(',') : [];

      // 중복 검사 및 새로운 검색어 추가
      if (searchQuery && searchList.indexOf(selectedRegion + ':' + searchQuery) === -1) {
        searchList.push(selectedRegion + ':' + searchQuery);

        // 최대 개수를 초과하는 경우 가장 오래된(첫 번째) 검색어 삭제
        if (searchList.length > MAX_SEARCH_HISTORY) {
          searchList.shift();
        }

        // 검색어 목록을 쿠키에 저장 (쉼표로 구분하여 저장)
        setCookie('searchHistory', searchList.join(','), 30); // 쿠키 유효기간 30일
      }

      var searchUrl = '/teamgg/board/searching_player?userName=' + encodeURIComponent(searchQuery);
      window.location.href = searchUrl;
    }
  });

  // 기존 쿠키 목록에서 li 요소를 클릭하면 검색 페이지로 이동
  $('.cookies li').on('click', function() {
    var searchQuery = $(this).text();
    var searchUrl = '/teamgg/board/searching_player?userName=' + encodeURIComponent(searchQuery);
    window.location.href = searchUrl;
  });
});
