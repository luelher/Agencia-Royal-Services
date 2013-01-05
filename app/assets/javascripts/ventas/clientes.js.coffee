# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


window.onload = -> 
  Gmaps.loadMaps()
  marker = Gmaps.map.markers[0]

  google.maps.event.addListener marker, 'dragend', ->
    $('#ventas_cliente_latitude')[0] = marker.getPosition().lat();
    $('#ventas_cliente_longitude')[0] = marker.getPosition().lng();
    return true