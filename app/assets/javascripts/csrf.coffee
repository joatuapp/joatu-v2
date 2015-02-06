$(document).on "page:change", (e)->
  token = $.cookie('csrftoken')

  $('<meta>')
    .attr('name', "csrf-param")
    .attr('content', 'authenticity_token')
    .appendTo('head')

  $('<meta>')
    .attr('name', 'csrf-token')
    .attr('content', token)
    .appendTo('head')

  $('input[name="authenticity_token"]').val(token)
