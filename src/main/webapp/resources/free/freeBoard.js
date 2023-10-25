				// 프로필박스
				document.addEventListener("DOMContentLoaded", function () {
						var writeButton = document.getElementById("write");
						var loginButton = document.getElementById("login");
								
							if (userName) {
								// 사용자가 로그인한 경우
								writeButton.style.display = 'block';
								loginButton.style.display = 'none';
							} else {
								// 사용자가 로그인하지 않은 경우
								writeButton.style.display = 'none';
								loginButton.style.display = 'block';
							}
						});


				// 사이드메뉴 버튼 스타일 고정
				window.onload = function() {
					var freeBtn = document.getElementById("side_free");
					var tipBtn = document.getElementById("side_tip");
					var compBtn = document.getElementById("side_comp");
					var currentURL = window.location.href;
				
					var freeURL = "http://localhost:8080/teamgg/free/";
					var tipURL = "http://localhost:8080/teamgg/tip/";
					var compURL = "http://localhost:8080/teamgg/comp/";
					
					if (currentURL.includes(freeURL)) {
						freeBtn.style.backgroundColor = "#dedcee"; // 배경색 변경
					}
					if (currentURL.includes(tipURL)) {
						tipBtn.style.backgroundColor = "#dedcee";
					}
					if (currentURL.includes(compURL)) {
						compBtn.style.backgroundColor = "#dedcee";
					}
				}