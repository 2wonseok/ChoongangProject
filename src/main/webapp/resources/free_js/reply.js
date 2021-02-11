// console.log("reply module...");

// ${root}

var replyService = (function() {

	// 댓글 리스트
	function getList(param, callback, error) {
		var free_seq = param.free_seq;
		var page = param.page || 1;
		// javascript 
		// boolean false : 0, "", null, undefined
		
		$.getJSON(appRoot + "/freeboard/replies/pages/" + free_seq + "/" + page, function(data) {
			if (callback) {
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}

	// 댓글 등록
	function add(data, callback, error) {
		console.log(data);
		
		$.ajax({
			type: "post",
			url: appRoot + "/freeboard/replies/new",  // context root로 변경
			data: JSON.stringify(data),     // form data를 json
			contentType: "application/json; charset=utf-8",
			success: function(result, stauts, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}


	//댓글 삭제
	function remove(reply_seq, callback, error) {
		$.ajax({
			type: 'delete',
			url: appRoot + '/freeboard/replies/' + reply_seq,
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	//댓글 수정
	function update(data, callback, error) {
		$.ajax({
			type: 'put',
			url: appRoot + '/freeboard/replies/' + data.reply_seq,
			data: JSON.stringify(data),
			contentType: 'application/json; charset=utf-8',
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function get(reply_seq, callback, error) {
		$.get(appRoot + '/freeboard/replies/' + reply_seq, function(data) {
			if (callback) {
				callback(data);
			}
		}).fail(function() {
			if (error) {
				error();
			}
		});
	}

	return {
//		name:"AAAA",
		add: add,
		getList: getList,
		remove: remove,
		update: update,
		get: get
	};
})();






