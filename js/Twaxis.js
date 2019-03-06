/* JavaScript functions for Twaxis web application
 * COM1001 Spring Semester Assignment 2019
 * Jamie Huddlestone
 */

var Twaxis = {
	
	// Generic method for AJAX calls; probably easier to use .get() or .post(), see below.
	ajax: function (method, url, data, callback) {
		
		var request = new XMLHttpRequest();
		
		request.open(method, url);
		
		if (typeof callback == "function") {
			request.addEventListener("load", callback);
		}
		
		if (typeof data == "object") {
			var serial = [];
			for (var property in data) {
				serial.push(property +"="+ data[property]);
			}
			data = serial.join("&");
			
			if (method.toUpperCase() == "POST") {
				request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				data = encodeURI(data).replace(/%20/g, "+");
			}
		}
		
		if (method.toUpperCase() == "GET") {
			url += "?"+ encodeURI(data);
			request.send();
		}
		else {
			request.send(data);
		}
		
		return request;
	},
	
	// Specific function for GET requests.
	get: function (url, data, callback) {
		return this.ajax("GET", url, data, callback);
	},
	
	// Specific function to POST data with AJAX... use this!
	post: function (url, data, callback) {
		return this.ajax("POST", url, data, callback);
	}
};