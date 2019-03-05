/* JavaScript functions for Twaxis web application
 * COM1001 Spring Semester Assignment 2019
 * Jamie Huddlestone
 */

var Twaxis = {
	
	// Generic method for AJAX calls; probably easier to use .get() or .post(), see below.
	ajax: function (method, url, data, callback) {
		
		var request = new XMLHttpRequest;
		request.open(method, url);
		if (typeof data == "object") {
			request.setRequestHeader("Content-Type", "application/json");
			data = JSON.stringify(data);
		}
		// Uncomment if we need to force the returned data type.
		//request.responseType = "text";
		request.addEventListener("load", callback);
		request.send(data);
		
		return request;
	},
	
	// Specific function for GET requests.
	get: function (url, callback) {
		return ajax("GET", url, null, callback);
	},
	
	// Specific function to POST data with AJAX... use this!
	post: function (url, data, callback) {
		return ajax("POST", url, data, callback);
	}
}