$(function() {		// << 이렇게 jquery 3.0 식으로 줄여쓰기. 대신 맨 아래 닫는 괄호들 주의.			
	var xhr = new XMLHttpRequest();	
	
	$("#cat1").click(function() {				
		$.ajax({				
			url: "/yy/api/dog",			
			method: "GET",			
			dataType: "json",			
			success: function(response) {			
				$("#cat1_area").text("이름:" + response.name + " 나이:" + response.age);		
			},			
			error: function(xhr, status, error) {			
				console.error(error);		
			}			
		});						
	});
	
	var myDiv = $('#cat');					
	myDiv.on('click', function() {  // 요소에 클릭 이벤트 처리					
	// var randomDistance = Math.floor(Math.random() * 200);				
	var randomDistance = 100;				
	myDiv.animate(				
		{			
			top : '+=' + randomDistance + 'px'		
		}, 1000, 'easeOutBack', function() {			
			console.log('Animation finished');		
		});			
	});				
					
	$("#cat2").click(function() {				
		$.ajax({					
			url: "/yy/api/catTwo",				
			method: "GET",				
			data: {"a":"야옹"},				
			success: function(response) {				
				$("#cat2_area").text("이름:" + response.name + " 나이:" + response.age);			
			},				
			error: function(xhr, status, error) {				
				console.error(error);			
			}				
		});								
	});				
					
});	// 이렇게 마무리 해야되는거 주의.				