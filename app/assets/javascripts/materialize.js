$(document).on('turbolinks:load', function(){
  $('ul.tabs').tabs();
  Materialize.updateTextFields();
  $('.dropdown-button').dropdown({
    inDuration: 300,
    outDuration: 225,
    constrain_width: false, // Does not change width of dropdown to that of the activator
    hover: true, // Activate on hover
    gutter: 0, // Spacing from edge
    belowOrigin: true, // Displays dropdown below the button
    alignment: 'left' // Displays dropdown with edge aligned to the left of button
  });
  $('.collapsible').collapsible({
    accordion : true
  });
  $('.slider').slider({

  });
  $('.tabs-wrapper').pushpin({
    top: 200,
    offset: 60,
    bottom: 500

  });
  $('.tooltipped').tooltip({

  });
  $('.modal-trigger').leanModal({
    dismissible: true,
    opacity: .5,
    in_duration: 300,
    out_duration: 200,
    starting_top: '4%',
    ending_top: '10%'

  })
});
