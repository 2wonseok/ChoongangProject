var revService = (function() {
	
	function goodAdd(rev_seq, callback, error) {
		
		$.ajax({
			type: "get",
			url: appRoot + "/rev/get/like",
			contentType: "application/json; charset=UTF-8",
			success: function(result, status, xhr) {
				console(result, status);
				if	(callback !== undefined) { // undefined가 아니면 true 이므로 생략가능.
				callback(result);
				}
			},
			error: function(xhr, status, er) { // undefined가 아니면 true 이므로 생략가능.
				if (error) {
				error(er);
				}
			}
		});
	}
	
	
	return {
		goodAdd: goodAdd
		};
})();

