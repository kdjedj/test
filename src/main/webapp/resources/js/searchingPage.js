$(document).ready(function() {
    const mainTabs = $('.main-tab ul li');
    const subTabs = $('.sub-tab');
    const underBox = $('.searchbox');
    const underBar = $('.under-bar');

    const qtsb = $('.queue_type_select_button');
    const total =$('#total');
    const soloRank =$('#soloRank');
    const normalGame =$('#normalGame');
    
    const divAllLi = $('div.queue_content');
    //const liElements = divAllLi.querySelectorAll('>li');
    const liElements = document.querySelectorAll('div.queue_content > li');
    
    $('.addInfoBtn').click(function() {
      // 클릭된 버튼의 부모 div에서 데이터를 가져옵니다.
      var $div = $(this).closest('.addBtnDiv');
      var $parents = $div.parent().parent();
      // 예: 해당 div의 배경색을 변경합니다.
     // $div.children('add_info').css('display', 'block');
     $parents.find('.addInfo').toggleClass('hidden');
      $(this).toggleClass('rotated');
     
  });


//   function showDiv(group) {
//     var elements = document.querySelectorAll('.' + group);
//     elements.forEach(function(element) {
//         element.style.display = 'block';
//     });
// }

// function hideDiv(group) {
//     var elements = document.querySelectorAll('.' + group);
//     elements.forEach(function(element) {
//         element.style.display = 'none';
//     });
// }

// document.getElementById('showDiv1Button').addEventListener('click', function() {
//     showDiv('div1');
//     hideDiv('div2');
// });

// document.getElementById('showDiv2Button').addEventListener('click', function() {
//     showDiv('div2');
//     hideDiv('div1');
// });

// document.getElementById('showAllButton').addEventListener('click', function() {
//     showDiv('div1');
//     showDiv('div2');
// });



    //경기 버튼 색깔 입히기
    total.on('click', function(){
        console.log('버튼 클릭함');
          soloRank.removeClass('selected');
          normalGame.removeClass('selected');
           $(this).addClass('selected');
        
          for(let i = 0; i < liElements.length ; i++){
            var li = liElements[i];
            li.style.display = 'block';
          }
        // $(this).css('background-color','#9759ff');
        // soloRank.css('background-color', '#fff');
        // normalGame.css('background-color', '#fff');

        //코드를 추가하게 만들기

    })

      







    soloRank.on('click', function(){
      console.log('버튼 클릭함');
        total.removeClass('selected');
        normalGame.removeClass('selected');
      $(this).addClass('selected');

        //코드를 추가하게 만들기

        for(let i = 0; i < liElements.length ; i++){
          var li = liElements[i];
          var gameTypeDiv = li.querySelector('.gameType').textContent;
          if(gameTypeDiv != "솔랭"){
            li.style.display = 'none';
        } else {
          li.style.display = 'block';
        }
        }
    })

        normalGame.on('click', function(){
          console.log('버튼 클릭함');
            soloRank.removeClass('selected');
            total.removeClass('selected');
            $(this).addClass('selected');
        
            for(let i = 0; i < liElements.length ; i++){
              var li = liElements[i];
              var gameTypeDiv = li.querySelector('.gameType').textContent;
              if(gameTypeDiv == "솔랭"){
                li.style.display = 'none';
            } else {
              li.style.display = 'block';
            }
            }

          // console.log('버튼 클릭함');
        // total.css('background-color', 'initial');
        // soloRank.css('background-color', 'initial');
        // normalGame.css('background-color', 'initial');

        // $(this).css('background-color','#9759ff');
        // soloRank.css('background-color', '#fff');
        // total.css('background-color', '#fff');

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