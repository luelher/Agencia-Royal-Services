# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = ->
  $('[data-behaviour~=datepicker]').datepicker()

  jQuery("#btn_xls").click => 
    $("#new_profit_factura")[0].action += ".xls"
    return true

  jQuery("#btn_html").click => 
    $("#new_profit_factura")[0].action = "/cobranzas/show"
    return true    