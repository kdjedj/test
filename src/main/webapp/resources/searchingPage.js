$(document).ready(function() {
    const mainTabs = $('.main-tab ul li');
    const subTabs = $('.sub-tab');
    const underBox = $('.searchbox');
    const underBar = $('.under-bar');

    const qtsb = $('.queue_type_select_button');
    const total =$('#total');
    const soloRank =$('#soloRank');
    const normalGame =$('#normalGame');
    
    //경기 버튼 색깔 입히기
    total.on('click', function(){
        console.log('버튼 클릭함');
        total.css('background-color', 'initial');
        soloRank.css('background-color', 'initial');
        normalGame.css('background-color', 'initial');

        $(this).css('background-color','#9759ff');
        soloRank.css('background-color', '#fff');
        normalGame.css('background-color', '#fff');

        //코드를 추가하게 만들기

    })

    soloRank.on('click', function(){
        console.log('버튼 클릭함');
        total.css('background-color', 'initial');
        soloRank.css('background-color', 'initial');
        normalGame.css('background-color', 'initial');

        $(this).css('background-color','#9759ff');
        total.css('background-color', '#fff');
        normalGame.css('background-color', '#fff');

        //코드를 추가하게 만들기

    })

        normalGame.on('click', function(){
        console.log('버튼 클릭함');
        total.css('background-color', 'initial');
        soloRank.css('background-color', 'initial');
        normalGame.css('background-color', 'initial');

        $(this).css('background-color','#9759ff');
        soloRank.css('background-color', '#fff');
        total.css('background-color', '#fff');

        //코드를 추가하게 만들기

    })



    //상단탭 클릭시 해당탭&하단탭 색상변경
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
    
  
    
    //검색창 클릭시 서치패널 보이게
    underBox.on('click', function() {
    
        underBar.children('.search-panel').css('display', 'block');
      
      // 다른 곳을 클릭해도 서치 패널이 바로 닫히지 않도록
      event.stopPropagation();
        
        });
        
        //서치패널 숨기기
        $(document).on('click', function() {
      underBar.children('.search-panel').css('display', 'none');
    });
  });