    function toggleReplyForm(button) {
        var replyForm = button.parentElement.nextElementElement;
        if (replyForm.style.display === "none") {
            replyForm.style.display = "block";
        } else {
            replyForm.style.display = "none";
        }
    }