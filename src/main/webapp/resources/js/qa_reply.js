//

var replyService = (function() {

	
	function getList(param, callback, error) {
		var seq = param.qa_seq;
		var page = param.page || 1;	
		// javascript
		// boolean false : 0, "", null, undefined	
	
		$.getJSON(appRoot + "/reply/pages/" + seq + "/" + page, function(data) {
			if(callback) {
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});		
	}
	
	//일반 유저 댓글쓰기
	function add(data, good, miss) {
		console.log(data);
		
		$.ajax({
			type: "post",
			url: appRoot + "/reply/register",			// context root로 변경
			data: JSON.stringify(data),		// form data를 json으로
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
	
	
	//관리자 댓글 쓰기
	function add_admin(data, good, miss) {
		console.log(data);
		
		$.ajax({
			type: "post",
			url: appRoot + "/reply/register_admin",			// context root로 변경
			data: JSON.stringify(data),		// form data를 json으로
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
	
	//삭제 (일반)
	function remove(reply_seq, callback, error) {
		$.ajax({
			type: "delete",
			url: appRoot + "/reply/" + reply_seq,
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				};
			},
			error: function(xhr, status, er) {
				if(error) {
				error(er);
				};
			}
		});
	};
	
	
	//삭제 (관리자)
	function remove_admin(reply_seq, callback, error) {
		$.ajax({
			type: "delete",
			url: appRoot + "/reply/delete/" + reply_seq,
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				};
			},
			error: function(xhr, status, er) {
				if(error) {
				error(er);
				};
			}
		});
	};
	
	//수정
	function modify(reply, callback, error) {
		$.ajax({
			type: "put",
			url: appRoot + "/reply/" + reply.reply_seq,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=UTF-8",
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				};
			},
			error: function(xhr, status, er) {
				if(error) {
					error(er);
				};
			}
		});
	};
	
	function get(reply_seq, callback, error) {
		$.get(appRoot + '/reply/' + reply_seq, function(data) {
			if (callback) {
				callback(data);
			}
		}).fail(function() {
			if (error) {
				error();
			}
		});
	};
	
	return {
		getList: getList,
		add: add,
		add_admin: add_admin,
		remove: remove,
		remove_admin: remove_admin,
		modify: modify,
		get: get
		};
	
})();

	