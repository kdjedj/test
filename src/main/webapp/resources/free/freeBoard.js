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

				// 게시판 탭 스타일 고정
				window.onload = function() {
					var freeBtnSide = document.getElementById("side_free");
					var tipBtnSide = document.getElementById("side_tip");
					var compBtnSide = document.getElementById("side_comp");
					var freeBtnHead = document.getElementById("head_free");
					var tipBtnHead = document.getElementById("head_tip");
					var compBtnHead = document.getElementById("head_comp");

					var currentURL = window.location.href;
				
					var freeURL = "http://localhost:8080/teamgg/free/";
					var tipURL = "http://localhost:8080/teamgg/tip/";
					var compURL = "http://localhost:8080/teamgg/comp/";
					
					if (currentURL.includes(freeURL)) {
						freeBtnSide.style.backgroundColor = "#EBE9FC"; // 배경색 변경
						freeBtnHead.style.borderBottom = "3px solid white";
					}
					if (currentURL.includes(tipURL)) {
						tipBtnSide.style.backgroundColor = "#EBE9FC";
						tipBtnHead.style.borderBottom = "3px solid white";
					}
					if (currentURL.includes(compURL)) {
						compBtnSide.style.backgroundColor = "#EBE9FC";
						compBtnHead.style.borderBottom = "3px solid white";
					}
				}