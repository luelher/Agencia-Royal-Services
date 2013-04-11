# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = ->
  $('[data-behaviour~=datepicker]').datepicker({
    format: 'yyyy-mm-dd',
    language: "es",
    autoclose: true
  })

  jQuery("#btn_xls").click => 
    $("#new_profit_factura")[0].action = "/cobranzas/show.xls"
    return true

  jQuery("#btn_html").click => 
    $("#new_profit_factura")[0].action = "/cobranzas/show"
    return true    

  $("#tfacturas").tablesorter()

  $("#tfacturas").tablesorterPager({
    page: 0, 
    size: 4, 
    container: $(".pager"),
    output: 'de {startRow} hasta {endRow} ({totalRows})',
    cssNext: '.next',
    cssPrev: '.prev',
    cssFirst: '.first',
    cssLast: '.last',
    cssPageDisplay: '.pagedisplay',
  })