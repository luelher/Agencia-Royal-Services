# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = ->
  format_cliente = (item) -> 
      "<li><p>" + item.co_cli + " <b style='color: red'>" + item.cli_des + "</b></p></li>"

  $("#ventas_seguimiento_cliente_id").tokenInput "/ventas/presupuestos/clientes.json", {
    crossDomain: false,
    tokenLimit: 1,
    tokenValue: "co_cli",
    searchingText: "Buscando...",
    noResultsText: "Sin Resultados",
    hintText: "Tipee la cédula del cliente",
    minChars: 2,
    propertyToSearch: "co_cli",
    resultsFormatter: format_cliente,
    tokenFormatter: format_cliente
  }
