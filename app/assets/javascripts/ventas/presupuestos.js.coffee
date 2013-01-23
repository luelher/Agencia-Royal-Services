# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = ->
  format_cliente = (item) -> 
      "<li><p>" + item.co_cli + " <b style='color: red'>" + item.cli_des + "</b></p></li>"
  format_producto = (item) -> 
      "<li><p>" + item.co_art + " <b style='color: red'>" + item.art_des + "</b> <b style='color: black'>Precio: " + item.prec_vta5 + "</b> <b style='color: red'>(" + item.stock_act + ")</b></p></li>"

  $("#ventas_presupuesto_cliente_id").tokenInput "clientes.json", {
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

  $("#ventas_presupuesto_producto").tokenInput "productos.json", {
    crossDomain: false,
    tokenLimit: 1,
    tokenValue: "co_art",
    searchingText: "Buscando...",
    noResultsText: "Sin Resultados",
    hintText: "Tipee el nombre del producto",
    minChars: 2,
    propertyToSearch: "art_des",
    resultsFormatter: format_producto,
    tokenFormatter: format_producto,
    onAdd: (item) ->
      $("#ventas_presupuesto_producto").val(item.co_art)
      window.codart = item.co_art
      window.nomart = item.art_des
      window.preart = Number(item.prec_vta5)
      window.exiart = Number(item.stock_act)
  }

  update_total = ->
    total = $('.total')
    suma = 0
    for t in total
      do (t) ->
        suma = parseFloat(t.innerHTML,10)
    $('#ventas_presupuesto_total').val(suma)




  $("#btn-agregar").click ->
    intVal = parseInt($('#ventas_presupuesto_cantidad').val(), 10)

    if(isNaN(intVal) || intVal <= 0)
      alert "La cantidad es inválida"
      return false;

    if $("#ventas_presupuesto_cantidad").val() != "" and $("#ventas_presupuesto_producto").val() != ""
      $("#detalle_tabla").after("
        <tr>
          <td>
            " + window.codart + "
            <input type=hidden name=\"ventas_presupuesto[detalle_presupuesto][][codigo]\" value=\"" + window.codart + "\"/>
          </td>
          <td>" + window.nomart + "</td>
          <td>" + window.preart.toFixed(2) + " Bs</td>
          <td>
            " + intVal + "
            <input type=hidden name=\"ventas_presupuesto[detalle_presupuesto][][cantidad]\" value=\"" + intVal + "\"/>
          </td>
          <td> <strong class=\"total\"> " + (intVal * window.preart).toFixed(2) + " </strong> Bs</td>
        </tr>
      ");
      update_total()
    else
      alert "Debe seleccionar el producto y agregar la cantidad"
    return true

  return true