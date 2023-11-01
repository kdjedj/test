				// 수정, 삭제 버튼 처리(글)
				document.addEventListener("DOMContentLoaded", function () {
					var readActionDiv = document.querySelector(".read_action");		    
						if (userId === tId) {
									readActionDiv.style.display = 'block';
								} else {
									readActionDiv.style.display = 'none';
								}
							});	

				// 글 삭제 팝업
				document.getElementById('read_delete').addEventListener('click', function () {
					var tIdx = this.getAttribute('data-t-idx');
					if (confirm("삭제하시겠습니까?")) {
						location.href = 'tipDel?t_idx=' + tIdx;
					} else {
						window.close();
					}
				});
                            
				// 답글 버튼
                var replyButtons = document.querySelectorAll('.replyForm-btn');
                replyButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var replyContainer = this.parentElement.parentElement;
                        var replyForm = replyContainer.querySelector('.replyForm');
                        var replyList = replyContainer.querySelector('.replyList');
                        replyForm.classList.toggle('hidden');
                        replyList.classList.toggle('hidden');
                    });
                });		
               
               // 수정, 삭제 버튼 처리(댓글)
                var modifyButton = document.querySelector('.replyForm-modify');
                var writerId = modifyButton.getAttribute('data-tc-id');
                var btnTrue = document.querySelectorAll('.btnTrue');
                var btnFalse = document.querySelectorAll('.btnFalse');
                if (isLoggedIn && currentUserId === writerId) {
                    btnTrue.forEach(function (btn) {
                        btn.style.display = 'block';
                    });
                    btnFalse.forEach(function (btn) {
                        btn.style.display = 'none';
                    });
                } else {
                    btnTrue.forEach(function (btn) {
                        btn.style.display = 'none';
                    });
                    btnFalse.forEach(function (btn) {
                        btn.style.display = 'block';
                    });
                    var commentReplyButton = document.querySelectorAll('.replyForm-btn');
                    commentReplyButton.forEach(function(button) { // false일때 답글버튼 띄우기
                        button.style.marginLeft = '30px';
                    });
                }			

                	             // 수정 버튼 클릭 시 모달 열기
	             var modifyButtons = document.querySelectorAll('.replyForm-modify');
	             modifyButtons.forEach(function (button) {
	                 button.addEventListener('click', function () {
	                 	// 버튼에서 tc_idx 값 꺼내옴
	                     var editTcIdx = this.getAttribute('data-tc-idx');
	                     var writerId = this.getAttribute('data-tc-id');
						 var tcComment = this.getAttribute('data-tc-comment'); // 원댓 내용 설정
	                     var modal = document.getElementById('commentModal');
	                     var modalContent = modal.querySelector('.modal-content');
	                     var tcIdxInput = modalContent.querySelector('input[name="tc_idx"]');
	                     // 꺼내온 tc_idx 값 설정
	                     tcIdxInput.value = editTcIdx;
						// 원댓 내용 설정
						var tcCommentInput = modalContent.querySelector('textarea[name="tc_comment"]');
						tcCommentInput.value = tcComment;
	             if (isLoggedIn && currentUserId === writerId) {
	                 // 로그인된 상태에서만 모달 열기
	                 modal.style.display = 'block';
	                 console.log('editTcIdx:', editTcIdx);
	                 console.log('tcIdxInput:', tcIdxInput);
	                 console.log('writerId:', writerId);
	             } else {
	                 // 비로그인 상태에서는 페이지 이동
	                 window.location.href = '/teamgg/member/login';
	             }
	                 });
	             });			

	             // 취소버튼으로 모달 닫기
	             var cancelEditButton = document.querySelector('#modifyForm-cancel');
	             cancelEditButton.addEventListener('click', function () {
	                 var modal = document.getElementById('commentModal');
	                 modal.style.display = 'none';
            	});

				// 수정 확인 팝업
				document.addEventListener("DOMContentLoaded", function () {
					// 수정 버튼 클릭 시
					var modalModifyButton = document.getElementById("modal-modify");
					modalModifyButton.addEventListener("click", function () {
						if (confirm("수정하시겠습니까?")) {
							// 팝업 확인을 누르면 폼을 제출
							document.getElementById("form").submit();
						}else{
							window.close();
						}
					});
				});

				// 댓글 삭제 팝업
				document.getElementById('comment_delete').addEventListener('click', function () {
					var tcIdx = this.getAttribute('data-tc-idx');
					if (confirm("삭제하시겠습니까?")) {
						location.href = '/teamgg/comment/tcDel?tc_idx=' + tcIdx;
					} else {
						window.close();
					}
				});
				
				// 대댓글 삭제 팝업
				document.getElementById('reply_delete').addEventListener('click', function () {
					var tcIdx = this.getAttribute('data-tc-idx');
					if (confirm("삭제하시겠습니까?")) {
						location.href = '/teamgg/comment/tcDel?tc_idx=' + tcIdx;
					} else {
						window.close();
					}
				});