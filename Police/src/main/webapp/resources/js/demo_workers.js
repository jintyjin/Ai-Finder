var i = 0;

function timedCount(start_time) {
	if (new Date().getTime() - start_time > 1000) {
	    i = i + 1;

	    postMessage(i);

	    //console.log("count = " + i);
		
	}
    setTimeout("timedCount(" + start_time + ")",1000);
}

var today = new Date();

timedCount(today.getTime());

