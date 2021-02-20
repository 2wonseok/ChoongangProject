// console.log("category module....");

var categoryService = (function() {
	
	function getCategorySubList(categoryMain, callback, error) {
		$.ajax({
			type: "POST",
			url: appRoot + "/product/getCategorySub",
			data: ''+categoryMain+'',
			contentType: "application/json; charset=utf-8",
			dataType: "json",		
			success: function(result, status, xhr) {
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
	
	function getCategorySeq(data, callback, error) {
		$.ajax({
			type: "POST",
			url: appRoot + "/product/getCategorySeq",
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function(result, status, xhr) {
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
		getCategorySubList: getCategorySubList,
		getCategorySeq : getCategorySeq
	};
})();

