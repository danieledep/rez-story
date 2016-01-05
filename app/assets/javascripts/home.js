if (typeof(NowPlaying) === 'undefined') {
	var NowPlaying = {};
}

NowPlaying.Home = function() {

	var getTweets = function(lat, lng) {
		$.get(
			'/tweets/search',
			{ lat: lat, lng: lng, count: 5 }
		).done(function(resp) {
			jQuery('#tweet-area').html(resp);
		});
	};

	var setFormLocation = function(lat, lng) {
		$('#tweet-form #tweet_lat').val(lat);
		$('#tweet-form #tweet_lng').val(lng);
	};

	var setup = function() {
		navigator.geolocation.getCurrentPosition(function(position) {
		  getTweets(position.coords.latitude, position.coords.longitude);
		  setFormLocation(position.coords.latitude, position.coords.longitude);
		});
	};

	return { setup: setup};

}();