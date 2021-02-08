//

var replyService = (function() {

	function addMethod(test, good, miss) {
		console.log("add1 method");
		console.log(test);
		
		$.ajax({
			type: "post",
			url: appRoot + "/reply/register",			// context root로 변경
			data: JSON.stringify(test),					// form data를 json으로
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if(good) {
				good(result);
				}
			},
			error: function(xhr, status, er) {
				if(miss) {
				miss(er);
				}
			}
		})
	}
	
	return {
		add: addMethod,

		};
	
})();

	