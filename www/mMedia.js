
var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

var mmediaExport = {};

mmediaExport.AD_POSITION = {
  NO_CHANGE: 0,
  TOP_LEFT: 1,
  TOP_CENTER: 2,
  TOP_RIGHT: 3,
  LEFT: 4,
  CENTER: 5,
  RIGHT: 6,
  BOTTOM_LEFT: 7,
  BOTTOM_CENTER: 8,
  BOTTOM_RIGHT: 9,
  POS_XY: 10
};

/*
 * set options:
 *  {
 *    position: integer, // default position
 *    x: integer,	// default X of banner
 *    y: integer,	// default Y of banner
 *    autoShow: boolean,	// if set to true, no need call showBanner or showInterstitial
 *   }
 */
mmediaExport.setOptions = function(options, successCallback, failureCallback) {
	  if(typeof options === 'object') {
		  cordova.exec( successCallback, failureCallback, 'mMedia', 'setOptions', [options] );
	  } else {
		  if(typeof failureCallback === 'function') {
			  failureCallback('options should be specified.');
		  }
	  }
	};

mmediaExport.createBanner = function(args, successCallback, failureCallback) {
	var options = {};
	if(typeof args === 'object') {
		for(var k in args) {
			if(k === 'success') { if(args[k] === 'function') successCallback = args[k]; }
			else if(k === 'error') { if(args[k] === 'function') failureCallback = args[k]; }
			else {
				options[k] = args[k];
			}
		}
	} else if(typeof args === 'string') {
		options = { adId: args };
	}
	cordova.exec( successCallback, failureCallback, 'mMedia', 'createBanner', [ options ] );
};

mmediaExport.removeBanner = function(successCallback, failureCallback) {
	cordova.exec( successCallback, failureCallback, 'mMedia', 'removeBanner', [] );
};

mmediaExport.hideBanner = function(successCallback, failureCallback) {
	cordova.exec( successCallback, failureCallback, 'mMedia', 'hideBanner', [] );
};

mmediaExport.showBanner = function(position, successCallback, failureCallback) {
	if(typeof position === 'undefined') position = 0;
	cordova.exec( successCallback, failureCallback, 'mMedia', 'showBanner', [ position ] );
};

mmediaExport.showBannerAtXY = function(x, y, successCallback, failureCallback) {
	if(typeof x === 'undefined') x = 0;
	if(typeof y === 'undefined') y = 0;
	cordova.exec( successCallback, failureCallback, 'mMedia', 'showBannerAtXY', [{x:x, y:y}] );
};

mmediaExport.prepareInterstitial = function(args, successCallback, failureCallback) {
	var options = {};
	if(typeof args === 'object') {
		for(var k in args) {
			if(k === 'success') { if(args[k] === 'function') successCallback = args[k]; }
			else if(k === 'error') { if(args[k] === 'function') failureCallback = args[k]; }
			else {
				options[k] = args[k];
			}
		}
	} else if(typeof args === 'string') {
		options = { adId: args };
	}
	cordova.exec( successCallback, failureCallback, 'mMedia', 'prepareInterstitial', [ args ] );
};

mmediaExport.showInterstitial = function(successCallback, failureCallback) {
	cordova.exec( successCallback, failureCallback, 'mMedia', 'showInterstitial', [] );
};

module.exports = mmediaExport;

