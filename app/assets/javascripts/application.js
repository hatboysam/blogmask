// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require foundation
//= require turbolinks
//= require loadjs
//= require_tree .

$(function(){ $(document).foundation(); });

/**
 * New Post Page JavaScript
 */
load({
  controllers: {
    posts: ['new', 'edit']
  }}, function(controller, actions) {

  // Controls the preview toggle
  var bodyEditable = true;

  // Content...
  var titleContent = "";
  var bodyContent = "";

  $(document).ready(function() {
    rangy.init();

    // Simple title editor
    $('#hallo-title').hallo();

    // Load the Hallo-JS Editor
    $('#hallo-editor').hallo({
      plugins: {
        'halloformat': {
          formattings: {
            bold: true,
            italic: true,
            strikethrough: true,
            underline: true
          }
        },
        'halloheadings': {},
        'hallojustify': {},
        'hallolists': {},
        'hallolink': {}
      },
      toolbar: 'halloToolbarFixed'
    });

    // Load current content
    $('#hallo-title').append($('#h-title-field').val());
    $('#hallo-editor').append($('#h-body-field').val());

    // Track edits
    $('#hallo-editor').on('hallomodified', function(e, data) {
      bodyContent = data.content;
      $('#h-body-field').val(bodyContent);
    });

    $('#hallo-title').on('hallomodified', function(e, data) {
      titleContent = data.content;
      $('#h-title-field').val(titleContent);
    });    

    // Add Preview Mode (toggle)
    $('#preview-button').on('click', function(e) {
      e.preventDefault();

      // Toggle edit mode and dotted lines
      $('.editor').hallo({ editable: !bodyEditable });
      $('.editor').toggleClass('dotted');

      // Flip the bit
      bodyEditable = !bodyEditable;
    });
  });
});