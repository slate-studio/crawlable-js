/**
 * Wait until the test condition is true or a timeout occurs. Useful for waiting
 * on a server response or for a ui change (fadeIn, etc.) to occur.
 *
 * @param testFx javascript condition that evaluates to a boolean,
 * it can be passed in as a string (e.g.: "1 == 1" or "$('#bar').is(':visible')" or
 * as a callback function.
 * @param onReady what to do when testFx condition is fulfilled,
 * it can be passed in as a string (e.g.: "1 == 1" or "$('#bar').is(':visible')" or
 * as a callback function.
 * @param timeOutMillis the max amount of time to wait. If not specified, 3 sec is used.
 */
function waitFor(testFx, onReady, timeOutMillis) {
  var maxtimeOutMillis = timeOutMillis ? timeOutMillis : 3000, //< Default Max Timout is 3s
    start = new Date().getTime(),
    condition = false,
    interval = setInterval(function() {
      if ( (new Date().getTime() - start < maxtimeOutMillis) && !condition ) {
        // If not time-out yet and condition not yet fulfilled
        condition = (typeof(testFx) === "string" ? eval(testFx) : testFx()); //< defensive code
      } else {
        if (!condition) {
          // If condition still not fulfilled (timeout but condition is 'false')
          // console.log("'waitFor()' timeout");
          phantom.exit(1);
        } else {
          // Condition fulfilled (timeout and/or condition is 'true')
          // console.log("'waitFor()' finished in " + (new Date().getTime() - start) + "ms.");
          typeof(onReady) === "string" ? eval(onReady) : onReady(); //< Do what it's supposed to do once the condition is fulfilled
          clearInterval(interval); //< Stop this interval
        }
      }
    }, 250); //< repeat check every 250ms
};



var system = require('system');
var page   = require('webpage').create();

var url                 = system.args[1];
var timeout             = Number(system.args[2]);
var isReadyCondition    = system.args[3] || "true";
var httpAuthCredentials = system.args[4];

eval("function isReadyTest() { return (" + isReadyCondition + "); }");

if (httpAuthCredentials) {
  page.customHeaders = {'Authorization': 'Basic ' + btoa(httpAuthCredentials)};
}

page.open(url, function (status) {
  if (status !== 'success') {
    console.log('Unable to access network');
    phantom.exit();
  } else {
    waitFor(function() {
      // Check in the page if a specific element is now visible
      if (isReadyTest) {
        return page.evaluate(isReadyTest);
      } else {
        return true;
      }
    }, function() {
      var html = page.evaluate(function () {
        return document.getElementsByTagName('html')[0].innerHTML
      });
      console.log(html);

      phantom.exit();
    }, timeout);
  }
});
