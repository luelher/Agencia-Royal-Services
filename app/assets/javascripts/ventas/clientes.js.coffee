# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = -> 
  Gmaps.loadMaps()

  Gmaps.map.HandleDragend = (pos) ->
    $('#ventas_cliente_latitude')[0].value = pos.lat();
    $('#ventas_cliente_longitude')[0].value = pos.lng();
    return true;

  Gmaps.map.callback = ->
    google.maps.event.addListener Gmaps.map.markers[0].serviceObject, 'dragend', ->
      Gmaps.map.HandleDragend this.getPosition()

  update_municipios = ->
    alert("Actualizando Municipios")

  $("#el_estado").change ->
    update_municipios()