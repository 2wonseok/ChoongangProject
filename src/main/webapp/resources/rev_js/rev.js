var revService = (function() {
	
	function goodAdd(rev_seq, callback, error) {
		
		
		
		$.getJSON(appRoot + "/rev/get/like", function(data) {
			if (callback) {
				callback(data);
				}
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
				}
		});
		
	}
	
		
	
	return {
		goodAdd: goodAdd
		};
})();

