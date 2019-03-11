/* Twaxis.js
 * JavaScript functions for Twaxis web application
 * COM1001 Spring Semester Assignment 2019
 * Jamie Huddlestone
 */

 
var Twaxis = {
	
	// Generic method for AJAX calls; probably easier to use .get() or .post(), see below.
	ajax: function (method, url, data, callback) {
		
		var request = new XMLHttpRequest();
		
		// Specify a callback function to execute when a request has been answered (successfully or otherwise).
		// The function will be passed the XMLHttpRequest object; use .responseText to access the returned data.
		if (typeof callback == 'function') {
			request.addEventListener('loadend', callback);
		}
		
		// Automatically serialise object data into the correct format for GET and POST requests.
		if (typeof data == 'object') {
			var serial = [];
			for (var property in data) {
				serial.push(property +"="+ data[property]);
			}
			switch (method.toUpperCase()) {
				case 'GET':
					data = "?"+ encodeURI(serial.join("&"));
					break;
				case 'POST':	// assumes Content-Type: application/x-www-form-urlencoded
					data = encodeURI(serial.join("&")).replace(/%20/g, "+");
					break;
				default:		// suitable for Content-Type: text/plain
					data = serial.join("\n");
			}
		}
		
		// Append data to the URL if it's a GET request.
		if (method.toUpperCase() == 'GET') {
			url += data;
		}
		
		// Make request and return XMLHttpRequest object.
		request.open(method, url);
		request.send(data);
		return request;
	},
	
	// Specific function for GET requests.
	get: function (url, data, callback) {
		return this.ajax('GET', url, data, callback);
	},
	
	// Specific function to POST data with AJAX... use this!
	post: function (url, data, callback) {
		return this.ajax('POST', url, data, callback);
	},
	
	// Toggle visibility of DOM elements.
	toggle: function (element) {
		element.classList.toggle('hidden');
		return element;
	},
	
	// Toggle visibility of multiple DOM elements.
	toggleAll: function (elements) {
		for (var i = 0; i < elements.length; i++) {
			elements[i].classList.toggle('hidden');
		}
		return elements;
	},
	
	// A concise way of toggling the visibility of multiple elements and specifying focus.
	expand: function (query, parentElement, focusElement) {
		query = query || '*';
		parentElement = parentElement || document;
		this.toggleAll(parentElement.querySelectorAll(query));
		if (focusElement) {
			focusElement.focus();
			return focusElement;
		} else return parentElement;
	}
};