$(document).ready(function() {
  const mainTabs = $('.main-tab ul li');
  const subTabs = $('.sub-tab');
  const underBox = $('.searchbox');
  const underBar = $('.under-bar');
  const searchInput = $('#searchInput'); // 검색어 입력 필드 선택
  const bookMarks = $('.bookmarks-list');
  const recentSearch= $('.recent-search');
  var MAX_SEARCH_HISTORY = 5; // 최대 검색어 개수
  
  // 쿠키를 읽어와서 검색어 입력 필드에 설정
  searchInput.val(getCookie('searchHistory'));

  var selectedRegion = "kr"; // 기본 리전 설정 (kr, na, jp 등)
  var li;
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
  
function updateStarColor(label, checkbox) {
  // 체크박스 상태 변경
  checkbox.prop('checked', !checkbox.prop('checked'));

  // 별 색깔 클래스 추가/제거
  if (checkbox.prop('checked')) {
    label.addClass('yellow-star');
  } else {
    label.removeClass('yellow-star');
  }
	  // 즐겨찾기 업데이트
	  updateFavorites();
}

// 최근검색&즐겨찾기 탭전환 함수
function switchToRecent() {
  $('.cookies').removeClass('bookmarks').addClass('recent');
  $('.recent-search').addClass('pick');
  $('.bookmarks-list').removeClass('pick');
}

function handleSearchBoxClick(){
	switchToRecent()
  	
    underBar.children('.search-panel').css('display', 'block');
    event.stopPropagation();
	// 서치패널 내에서 별 색깔을 변경할 요소를 찾아서 처리합니다.
    var label = $(event.target).closest('.favorite-summoner-list');

    if (label.length > 0) {
      // 별 색깔을 변경
      updateStarColor(label.siblings('input[type="checkbox"]'), label);
      var summonerName = label.parent().siblings('.summoner').text();
      updateFavorites(summonerName); // searchQuery를 전달
    }
    // 리전 업데이트
    selectedRegion = $('#kr').val();

    var searchHistory = getCookie('searchHistory');
    if (searchHistory) {
      var searchList = searchHistory.split(','); // 쿠키에서 검색어 목록 가져오기
      var cookiesList = $('.cookies'); // 쿠키 목록 요소 선택
      cookiesList.empty();
      
      li=null
      for (let i = 0; i < searchList.length; i++) {
        var searchData = searchList[i].split(':');
        var region = searchData[0]; // 리전
        var query = searchData[1]; // 검색어
		var favoriteClass = searchData[2] || ''; // 쿠키에서 가져온 클래스 (또는 빈 문자열)
		
        // 아이템을 생성하고 이벤트를 연결할 때마다 ID를 증가시킴
        li = $('<li>' +
            '<span class="test">' + region + '</span>' +
            '<span class="summoner">' + query + '</span>' +
            '<div class="favorite-summoner-chk">' +
	          '<input type="checkbox" id="fav_' + i +'" class="checkBox">' +
	          '<label for="fav_' + i +' " class="favorite-summoner-list ' + favoriteClass + '"></label>' +
            '</div>' +
            '<button type="button" class="close-btn">' + "X" +
      	    '</button>' +
          '</li>');


		
        // li 요소의 click 이벤트 핸들러에서 이벤트 중지
        li.on('click', function(event) {
          event.stopPropagation();
          
        });
		
        // 소환사명 누르면 전적검색 이동
        li.find('.summoner').on('click', function(event) {
          var searchQuery = $(this).text();
          var regionQuery = $(this).parent().find('.test').text();
          var searchUrl = '/teamgg/board/exist_user?userName=' + encodeURIComponent(searchQuery)+'&region='+encodeURIComponent(regionQuery);
          window.location.href = searchUrl;
        });

        // 아이템 클릭 이벤트 핸들러
        li.find('label').on('click', function(event) {
          event.stopPropagation();
		  updateStarColor($(this), $(this).siblings('input[type="checkbox"]'));

        // 즐겨찾기 업데이트
        updateFavorites();
		
		
		         
          
        });
		// 페이지 로드 시 초기화 함수 호출
		initialize();
		console.log("Initialize function called")
        cookiesList.append(li);
        initialize();
		
		
		
      } // for
    } //searchHistory if
    
    //삭제버튼 클릭시 li와 쿠키 삭제
	const closeBtn = $('.close-btn'); //삭제버튼
	closeBtn.on('click', function(event) {
		console.log('삭제버튼클릭');
	    event.stopPropagation();
	    var li = $(this).closest('li');
	    var region = li.find('.test').text();
	    var summoner = li.find('.summoner').text();
	
	    // 쿠키에서 해당 항목 제거
	    var searchHistory = getCookie('searchHistory');
	    if (searchHistory) {
	        var searchList = searchHistory.split(',');
	        var updatedList = [];
	
	        for (var i = 0; i < searchList.length; i++) {
	            var searchData = searchList[i].split(':');
	            if (searchData[0] !== region || searchData[1] !== summoner) {
	                updatedList.push(searchList[i]);
	            }
	        }
	
	        // 변경된 목록으로 쿠키 업데이트
	        setCookie('searchHistory', updatedList.join(','), 30);
	    }
	
	    // 해당 항목 삭제
	    li.remove();

  });
} //handleSearchBoxClick
		  
  // 검색창 클릭 시 서치패널 보이게
  underBox.on('click', function(event) {
  	console.log('검색창클릭')
  	handleSearchBoxClick()
    
	bookMarks.on("click", function(){
	  // 즐겨찾기 탭을 클릭했을 때 수행할 작업
	  console.log('즐겨찾기 탭 클릭');
	  var cookiesList = $('.cookies'); // 여기에서 변수를 정의합니다.
	  cookiesList.removeClass('recent').addClass('bookmarks');
	  $('.bookmarks-list').addClass('pick');
	  $('.recent-search').removeClass('pick');
	  
	  var favorites = getCookie('favorites');
	  if (favorites) {
	    var favoritesList = favorites.split(','); // 쿠키에서 검색어 목록 가져오기
	    cookiesList.empty();
	    
	    for (let i = 0; i < favoritesList.length; i++) {
	      var favoritesData = favoritesList[i].split(':');
	      var region = favoritesData[0]; // 리전
	      var query = favoritesData[1]; // 검색어
	      
	      // 아이템을 생성하고 이벤트를 연결할 때마다 ID를 증가시킴
	      var li = $('<li>' +
	        '<span class="test">' + region + '</span>' +
	        '<span class="summoner">' + query + '</span>' +
	        '<button type="button" class="close-btn">' + "X" +
      	    '</button>' +
	        '</li>');
	        
	        initialize();
	        console.log("Initialize function called")
	        cookiesList.append(li);
	        initialize();
	    }
	  } else {
	    // 쿠키에 데이터가 없을 때 빈 li 요소를 추가
	    var li = $('<li>' +
	      '<span class="test">즐겨찾기를 등록해보세요</span>' +
	      '<span class="summoner"></span>' +
	      '</li>');
	      
	    cookiesList.empty().append(li);
	  }
	  // bookmarks 탭에서 삭제 버튼 클릭 시 아이템 삭제
	$('.bookmarks .close-btn').on('click', function(event) {
	    event.stopPropagation();
	    var li = $(this).closest('li');
	    var region = li.find('.test').text();
	    var summoner = li.find('.summoner').text();
	
	    // 쿠키에서 해당 항목 제거
	    var favorites = getCookie('favorites');
	    if (favorites) {
	        var favoritesList = favorites.split(',');
	        var updatedFavorites = [];
	
	        for (var i = 0; i < favoritesList.length; i++) {
	            var favoritesData = favoritesList[i].split(':');
	            if (favoritesData[0] !== region || favoritesData[1] !== summoner) {
	                updatedFavorites.push(favoritesList[i]);
	            }
	        }
	
	        // 변경된 목록으로 쿠키 업데이트
	        setCookie('favorites', updatedFavorites.join(','), 30);
	    }

	    // 해당 항목 삭제
	    li.remove();
	
	    // 해당 항목의 노란 별을 빈 별로 변경
	    li.find('label').removeClass('yellow-star');
		});
	});
		
		
	recentSearch.on("click", function(){
	  switchToRecent();
  	  $('.recent-search').addClass('pick');
	  $('.bookmarks-list').removeClass('pick');
	  $('.cookies').removeClass('bookmarks').addClass('recent');
	  handleSearchBoxClick()
	  });
		
  });// 검색창 클릭 시 서치패널 보이게
  
  
// 서치패널 클릭 시 이벤트 중단
underBar.children('.search-panel').on('click', function(event) {
  event.stopPropagation();
});
  // 서치패널 숨기기
  $(document).on('click', function() {
    underBar.children('.search-panel').css('display', 'none');
    // 노란별 상태 업데이트
  });

  // 쿠키를 설정하는 함수 (쿠키는 쉼표로 구분하여 저장)
  function setCookie(name, value, days) {
    var expires = "";
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000)); //30일 설정
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
    var selectedRegion = $('select[name="region"]').val();
    if (searchQuery) {
      var searchHistory = getCookie('searchHistory');
      var searchList = searchHistory ? searchHistory.split(',') : [];

       // 중복 검사
	  if (searchList.indexOf(selectedRegion + ':' + searchQuery) === -1) {
      	var searchUrl = '/teamgg/board/exist_user?userName=' + encodeURIComponent(searchQuery) + '&region=' + encodeURIComponent(selectedRegion);
      // 검색 요청
      $.get(searchUrl, function(data) {
        if (data === 'success') {
          // 검색 성공한 경우에만 새로운 검색어 추가
          searchList.push(selectedRegion + ':' + searchQuery);

		
		
        // 최대 개수를 초과하는 경우 가장 오래된(첫 번째) 검색어 삭제
        if (searchList.length > MAX_SEARCH_HISTORY) {
          searchList.shift();
        }

        // 검색어 목록을 쿠키에 저장 (쉼표로 구분하여 저장)
        setCookie('searchHistory', searchList.join(','), 30); // 쿠키 유효기간 30일
      }
    });
	}
      var searchUrl = '/teamgg/board/exist_user?userName=' + encodeURIComponent(searchQuery)+'&region='+encodeURIComponent(selectedRegion);
      //var searchUrl = '/teamgg/board/searching_player?userName=' + encodeURIComponent(searchQuery)+'&region='+encodeURIComponent(selectedRegion);
      window.location.href = searchUrl;
    }
  });

  // 즐겨찾기 업데이트 함수
  function updateFavorites() {
  	console.log("updateFavorites called")
  	
    var favorites = [];
    $('.checkBox').each(function(index) {
      if ($(this).prop('checked')) {
        var summonerName = $(this).siblings('label').parent().siblings('.summoner').text();
        var selectedRegion = getSelectedRegion(summonerName);
        var label = $(this).siblings('label');
        var favoritesummonerName = label.parent().siblings('.summoner').text();
        var labelClasses = $(this).siblings('label').hasClass('yellow-star') ? 'yellow-star' : '';
      	favorites.push(selectedRegion + ':' + favoritesummonerName + ':' + labelClasses);
	    }
    });
    setCookie('favorites', favorites.join(','), 30);
  }
function getSelectedRegion(summonerName) {
  var searchHistory = getCookie('searchHistory');
  if (searchHistory) {
    var searchList = searchHistory.split(',');
    for (var i = 0; i < searchList.length; i++) {
      var searchData = searchList[i].split(':');
      var region = searchData[0];
      var query = searchData[1].trim();
      if (query === summonerName) {
        return region; // 서머너 이름이 일치하는 경우 해당 리전을 반환
      }
    }
  }
  return "오류";
  
}
  // 초기화 함수
  function initialize() {
    var favoriteData = getCookie('favorites');
    if (favoriteData) {
      var favorites = favoriteData.split(',');
      favorites.forEach(function(favorite) {
        var searchData = favorite.split(':');
        var region = searchData[0];
        var query = searchData[1];
        var labelClasses = searchData[2];
       // li 요소에 해당하는 모든 li 요소를 선택
      var matchingLiElements = $('.cookies li').filter(function() {
        return $(this).find('.summoner').text() === query;
      });

      matchingLiElements.each(function() {
        var li = $(this);
        var checkbox = li.find('.checkBox');
        var label = li.find('label');

        // 클래스 추가
        label.addClass(labelClasses);

        // 체크박스 상태 업데이트
        if (labelClasses.includes('yellow-star')) {
          checkbox.prop('checked', true);
        }
      });
    });
  }
}

});
