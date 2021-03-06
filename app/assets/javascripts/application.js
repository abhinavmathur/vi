// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require ahoy
//= require toastr
//= require jquery.slick
//= require rails.validations
//= require twitter/typeahead.min
//= require commontator/application
//= require sisyphus.min
//= require materialize-tags.min
//= require show_more.min
//= require_tree .
//= require turbolinks


$(document).ready(function() {
    $('.showmore').showMore({
        speedDown: 300,
        speedUp: 300,
        height: '350px',
        showText: 'Show more',
        hideText: 'Show less'
    });

    $('.review-form, .new-product').sisyphus();
});

