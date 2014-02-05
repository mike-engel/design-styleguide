var init, form, sectionHTML, doFunctions;

form = $('.generator-form');

sectionHTML = "<div class='section'><label for='section'>Another section in your styleguide</label><div class='remove-wrapper'><a href='#remove-section' class='remove-section' tabindex='-1'>&nbsp;</a><input tabindex='0' type='text' placeholder='Typography' name='section[]' class='section extra' data-required='true' data-trigger='change' data-required-message='Look, if you don't want this section, just remove it.' data-minlength='5' data-minlength-message='Your section titles need to be longer than 5 characters' /></div></div><div class='clear'></div>";

doFunctions = {
  addSection: function () {
    "use strict";
    form.children('#js-add-section').before(sectionHTML).show(250, function () {
      $('.section').last().focus();
    });
    $('html, body').animate({scrollTop: $(document).height() }, 150);
  },
  removeSection: function (el) {
    "use strict";
    el.closest('.section').hide(250).remove();
    $('html, body').animate({scrollTop: $(document).height() }, 150);
  }
};

init = {
  bind: function () {
    "use strict";
    $('body').on('click', '#js-add-section', function (e) {
      e.preventDefault();
      doFunctions.addSection();
    });
    $('body').on('click', '.section .remove-section', function (e) {
      e.preventDefault();
      var el = $(this);
      doFunctions.removeSection(el);
    });
    $(window).keydown(function (e) {
      if (e.keyCode === 13) {
        e.preventDefault();
        doFunctions.addSection();
      }
    });
  }
};

$(document).ready( function () {
  "use strict";
  init.bind();
});