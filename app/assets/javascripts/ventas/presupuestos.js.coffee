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

  $("#producto_extra").tokenInput "productos.json", {
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
      $("#producto_extra").val(item.co_art)
      window.codart = item.co_art
      window.nomart = item.art_des
      window.preart = Number(item.prec_vta5)
      window.exiart = Number(item.stock_act)
  }

  update_presupuesto = (tipo) ->
    D25 = 0.028333333;

    # $cal = $request->getParameter('calculadora');

    # $D18 = (float)$cal['monto_venta'];
    D18 = parseFloat($('#total_venta_extra').val())
    # $C20 = (float)$cal['porcentaje_inicial'];
    C20 = parseFloat($('#porcentaje_inicial_extra').val())

    # if($cal['giro_a_la_vista']!=''){
    #   if($cal['giro_a_la_vista']=='12'){
    #     $cal['monto_inicial'] = $D18 * (0.09046679);
    #     $cal['cuotas'] = '12';
    #   }elseif($cal['giro_a_la_vista']=='18'){
    #     $cal['monto_inicial'] = $D18 * (0.06689259);
    #     $cal['cuotas'] = '18';
    #   }
    # }
    # Nota: giro_a_la_vista_extra es un combo con 12, 18 meses o nada
    if $('#giro_a_la_vista_extra').val()!=''
      if $('#giro_a_la_vista_extra').val()=='12'
        $('#ventas_presupuesto_inicial').val((D18 * (0.09046679)).toFixed(2))
        $('#ventas_presupuesto_giros').val('12')
      else
        $('#ventas_presupuesto_inicial').val((D18 * (0.06689259)).toFixed(2))
        $('#ventas_presupuesto_giros').val('18')

    # if($cal['porcentaje_inicial']>0){
    #   $inicial = $D18*$C20/100;
    #   $porcentaje_inicial = $cal['porcentaje_inicial'];
    # }else{
    #   if($cal['monto_inicial']>0){
    #     $inicial = $cal['monto_inicial'];
    #     $porcentaje_inicial = ($inicial * 100) / $D18;
    #   }
    #   else {
    #     $inicial = 0;
    #     $porcentaje_inicial = 0;
    #   }
    # }
    if parseFloat($('#porcentaje_inicial_extra').val())>0.0 and tipo=='p'
      inicial = (D18*C20)/100
      porcentaje_inicial = parseFloat($('#porcentaje_inicial_extra').val())
    else
      if parseFloat($('#ventas_presupuesto_inicial').val())>0.0 and tipo=='c'
        inicial = parseFloat($('#ventas_presupuesto_inicial').val())
        porcentaje_inicial = (inicial * 100) / D18
      else
        inicial = 0
        porcentaje_inicial = 0


    # $H19 = (float)$cal['cuotas'];
    # $saldo = (float)$cal['monto_venta']-$inicial;
    # $G18 = $saldo;
    # $cuotas = (float)$cal['cuotas'];
    # $cuota_mensual = (($D25)*pow((1+$D25),$H19)/(pow((1+$D25),$H19)-1))*$G18;
    # $G23 = $cuota_mensual;
    # $D20 = $inicial;
    # $venta_credito = ($G23*$H19)+$D20;
    # $G27 = $venta_credito;
    # $G18 = $saldo;
    # $intereses = $G27-$G18-$D20;

    H19 = parseFloat($('#ventas_presupuesto_giros').val())
    saldo = parseFloat($('#total_venta_extra').val())-inicial;
    G18 = saldo
    cuotas = parseFloat($('#ventas_presupuesto_giros').val())
    cuota_mensual = ((D25)*Math.pow((1+D25),H19)/(Math.pow((1+D25),H19)-1))*G18;
    G23 = cuota_mensual;
    D20 = inicial;
    venta_credito = (G23*H19)+D20;
    G27 = venta_credito;
    G18 = saldo;
    intereses = G27-G18-D20;


    # $this->saldo = $saldo;
    # $this->cuotas = $cuotas;
    # $this->cuota_mensual = $cuota_mensual;
    # $this->venta_credito = $venta_credito;
    # $this->intereses = $intereses;
    # $this->inicial = $inicial;
    # $this->porcentaje_inicial = $porcentaje_inicial;

    $('#ventas_presupuesto_cuota').val(cuota_mensual.toFixed(2))
    $('#ventas_presupuesto_inicial').val(inicial.toFixed(2))
    $('#porcentaje_inicial_extra').val(porcentaje_inicial.toFixed(2))

  update_total = ->
    total = $('.total')
    suma = 0
    for t in total
      do (t) ->
        suma += parseFloat(t.innerHTML,10)
    $('#total_venta_extra').val(suma.toFixed(2))
    update_presupuesto()

  $("#giro_a_la_vista_extra").change ->
    update_presupuesto()

  $("#ventas_presupuesto_giros_especiales").change ->
    update_presupuesto()

  $("#ventas_presupuesto_giros").change ->
    update_presupuesto()

  $("#ventas_presupuesto_inicial").change ->
    update_presupuesto('c')    

  $("#porcentaje_inicial_extra").change ->
    update_presupuesto('p')

  $("#btn-agregar").click ->
    intVal = parseInt($('#cantidad_extra').val(), 10)

    if(isNaN(intVal) || intVal <= 0)
      alert "La cantidad es inválida"
      return false;

    total = (intVal * window.preart)
    iva = (total * 0.12)
    total_iva = (total + iva)

    if $("#cantidad_extra").val() != "" and $("#producto_extra").val() != ""
      $("#detalle_tabla").after("
        <tr id=\""+ window.codart + "\">
          <td>
            " + window.codart + "
            <input type=hidden name=\"ventas_presupuesto[detalle_presupuesto_attributes][][codigo]\" value=\"" + window.codart + "\"/>
          </td>
          <td>" + window.nomart + "</td>
          <td>" + window.preart.toFixed(2) + " Bs
            <input type=hidden name=\"ventas_presupuesto[detalle_presupuesto_attributes][][precio]\" value=\"" + window.preart.toFixed(2) + "\"/>
          </td>
          <td>
            " + intVal + "
            <input type=hidden name=\"ventas_presupuesto[detalle_presupuesto_attributes][][cantidad]\" value=\"" + intVal + "\"/>
          </td>
          <td> " + iva.toFixed(2) + " Bs</td>
          <td> <strong class=\"total\"> " + total_iva.toFixed(2) + " </strong> Bs</td>
          <td> <a href=\"javascript:$('#" + window.codart + "').remove();update_presupuesto();\" class=\"btn btn-mini btn-danger\" data-method=\"delete\" rel=\"nofollow\"><span class=\"translation_missing\" title=\"translation missing: es.helpers.links.destroy\">Destroy</span></a> </td>
        </tr>
      ");
      update_total()
      $("#producto_extra").tokenInput("clear")
    else
      alert "Debe seleccionar el producto y agregar la cantidad"
    return true

  return true