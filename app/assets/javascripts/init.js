$(document).ready(function($){

      $('ul.nav > li').each(function(){
    if ($(this).find('ul').length > 0)
    {


        //item has children; do whatever you want
        $("ul.sub-menu").addClass('dropdown-menu').css("display","none");


    }

        $("ul.sub-menu").parent().addClass('parent');
        $(".menu-header ul.nav .parent").addClass('dropdown');


        $('ul.sub-menu').hover(
           function(){
               $(this).parent().addClass('active');
           }, function(){
                 $(this).parent().removeClass('active');
           }
        );


         //Add Hover effect to menus
$('ul.nav li.parent').hover(function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn();
}, function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(30).fadeOut();
});


$(function ($) {
    $('[rel=tooltip]').tooltip()
});

});
// if(document.getElementById('click')){
// document.getElementById('click').click();
// }

  /** Tabs & Toggles
  -------------------------------*/
  // Tabs
  if($().tabs) {
    $(".aq_block_tabs").tabs({
      show: true
    });
  }

  // Toggles
  $('.aq_block_toggle .tab-head, .aq_block_toggle .arrow').each( function() {
    var toggle = $(this).parent();

    $(this).click(function() {
      toggle.find('.tab-body').slideToggle();
      return false;
    });

  });

  // Accordion
   $(function() {
    $( ".aq_block_accordion_wrapper" ).accordion();
    $('.ui-accordion-header').disableSelection();
  });

});