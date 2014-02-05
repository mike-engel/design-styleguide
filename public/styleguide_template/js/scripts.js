$(document).ready(function () {
  "use strict";
  if (window.location.hash) {
    $('.left-menu .nav').children("." + window.location.hash.substring(1)).addClass("active");
  } else {
    $('.left-menu .nav').first("li").addClass("active");
  }
});

//Removes index.html from URL 
var currentUrl = document.URL;

//Uncomment this if you don't want index.html in the URL
//var urlPos = currentUrl.indexOf("index.html");
//if( urlPos !== -1) {
//	currentUrl = currentUrl.replace("index.html", "");
//}

//Adds #typography if there is no location specified onload
if (currentUrl.indexOf("#") === -1) {
	currentUrl = currentUrl+"#typography";
}

document.location = currentUrl;

//Checks each section to see if it has been scrolled to, changes the class of the left nav to active
$(window).scroll(function () {
  "use strict";
  $('section').each(function () {
    if($(this).offset().top < $(window).scrollTop() + 100) {
      var thisID = $(this).attr("id");
      $('.left-menu .nav .active').removeClass("active");
      $('.left-menu .nav').children("." + thisID).addClass("active");
    }
  });
});

//Show CSS button animation js
$('section').on('click', '.code-button', function () {
  "use strict";
  var preID = this.id.substring(0,this.id.length - 7);
  if ($('#'+preID).css("display") === "none") {
          $('#'+this.id).html('Hide CSS <span class="arrow"></span>').addClass("code-open");
  } else {
          $('#'+this.id).html('Show CSS <span class="arrow"></span>').removeClass("code-open");
  }
  $('#'+preID).toggle('slow', function() {
    // Animation complete.
  });
});