// console.log("reply module....");

var replyService = (function() {
	
	function add(data, callback, error) {
	// reply : form data
	// callback : 성공했을때 일어날일
	// error : 실패했을때 일어날일
	//  console.log("add1 method1");
		
		
		$.ajax({
			type: "post",
			url: appRoot + "/replies/new", 
			data: JSON.stringify(data),			 // form data를 를 받아서 json형식으로 값을 넣어주는역할
			contentType: "application/json; charset=UTF-8",
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
	
	function getList(rev_seq, callback, error) {
		$.ajax({
			type: "GET",
			url: appRoot + "/replies/pages",
			dataType: "json",
			data: {"reply_boardseq": rev_seq},
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
	function remove(param, callback, error) {
		var rno = param.rno;
		
		$.ajax(appRoot + "/replies/" + rno, {
			type: "delete",
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
	
	function update(reply, callback, error) {
		
		$.ajax({
			type: "put",
			url: appRoot + "/replies/" + reply.rno, 
			data: JSON.stringify(reply),
			contentType: "application/json; charset=UTF-8",
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, err) {
				if (error) {
					error(err);
				}
			}
		});
		
	}
	
	function get(rno, callback, error) {
		$.get(appRoot + '/replies/' + rno, function(data) {
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
	// 앞의 add는 return의 add 뒤에 add는 위에 function add의 add
	// add라는 속성에 add라는 속성값을 가진 객체가 할당.
	};
})();

