				// 수정, 삭제 버튼 처리(글)
				document.addEventListener("DOMContentLoaded", function () {
					var readActionDiv = document.querySelector(".read_action");		    
						if (userId === fId) {
									readActionDiv.style.display = 'block';
								} else {
									readActionDiv.style.display = 'none';
								}
							});	

				// 글 삭제 팝업
				document.getElementById('read_delete').addEventListener('click', function () {
					var fIdx = this.getAttribute('data-f-idx');
					if (confirm("삭제하시겠습니까?")) {
						location.href = 'freeDel?f_idx=' + fIdx;
					} else {
						window.close();
					}
				});
                            
				// 답글 버튼
                var replyButtons = document.querySelectorAll('.replyForm-btn');
                replyButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var replyContainer = this.parentElement;
                        var replyForm = replyContainer.querySelector('.replyForm');
                        var replyList = replyContainer.querySelector('.replyList');
                        replyForm.classList.toggle('hidden');
                        replyList.classList.toggle('hidden');
                    });
                });		
               
				// 수정, 삭제 버튼 처리(댓글)
				var modifyButtons = document.querySelectorAll('.replyForm-modify');
				var deleteButtons = document.querySelectorAll('.replyForm-delete');
				var replyButtons = document.querySelectorAll('.replyForm-btn');

				modifyButtons.forEach(function (button) {
					var fcId = button.getAttribute('data-fc-id');
					if (fcId !== currentUserId) {
						button.style.display = 'none';
					}
				});
				deleteButtons.forEach(function (button) {
					var fcId = button.getAttribute('data-fc-id');
					if (fcId !== currentUserId) {
						button.style.display = 'none';
					}
				});	

				// 답글 버튼 스타일 변경
				replyButtons.forEach(function (button) {
					var fcId = button.getAttribute('data-fc-id');
					if (fcId !== currentUserId) {
						button.style.marginLeft = '30px'; // 현재 로그인된 사용자와 작성자 ID가 다를 때 왼쪽 여백 추가
					}
				});

                	             // 수정 버튼 클릭 시 모달 열기
	             var modifyButtons = document.querySelectorAll('.replyForm-modify');
	             modifyButtons.forEach(function (button) {
	                 button.addEventListener('click', function () {
	                 	// 버튼에서 fc_idx 값 꺼내옴
	                     var editFcIdx = this.getAttribute('data-fc-idx');
	                     var writerId = this.getAttribute('data-fc-id');
						 var fcComment = this.getAttribute('data-fc-comment'); // 원댓 내용 설정
	                     var modal = document.getElementById('commentModal');
	                     var modalContent = modal.querySelector('.modal-content');
	                     var fcIdxInput = modalContent.querySelector('input[name="fc_idx"]');
	                     // 꺼내온 fc_idx 값 설정
	                     fcIdxInput.value = editFcIdx;
						// 원댓 내용 설정
						var fcCommentInput = modalContent.querySelector('textarea[name="fc_comment"]');
						fcCommentInput.value = fcComment;
	             if (isLoggedIn && currentUserId === writerId) {
	                 // 로그인된 상태에서만 모달 열기
	                 modal.style.display = 'block';
	                 console.log('editFcIdx:', editFcIdx);
	                 console.log('fcIdxInput:', fcIdxInput);
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

				// 댓글 삭제 팝업
				document.getElementById('comment_delete').addEventListener('click', function () {
					var fcIdx = this.getAttribute('data-fc-idx');
					if (confirm("삭제하시겠습니까?")) {
						location.href = '/teamgg/comment/fcDel?fc_idx=' + fcIdx;
					} else {
						window.close();
					}
				});
				
				// 대댓글 삭제 팝업
				document.getElementById('reply_delete').addEventListener('click', function () {
					var fcIdx = this.getAttribute('data-fc-idx');
					if (confirm("삭제하시겠습니까?")) {
						location.href = '/teamgg/comment/fcDel?fc_idx=' + fcIdx;
					} else {
						window.close();
					}
				});