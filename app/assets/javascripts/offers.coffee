# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

setup_offer_form = ->
  $('#offer_visibility').change((e) ->
    if e.target.value == 'private'
      $('.visibility-settings').removeClass('hidden')
      $('.visibility-settings').show()
    else
      $('.visibility-settings').hide()
  )

$(document).on "page:change", (e) ->
  setup_offer_form()
$(document).on "ready", (e) ->
  setup_offer_form()
