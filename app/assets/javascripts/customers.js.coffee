# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	$('#customers_test').dataTable({
		pagingType: 'full_numbers',
		bProcessing: true,
		bServerSide: true,
		sAjaxSource: $('#customers_test').data('source')
	})

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:restore', ready)