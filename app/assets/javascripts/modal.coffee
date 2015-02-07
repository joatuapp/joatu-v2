root = exports ? window
root.populate_modal = (body, title = null)->
  # Clear header ahead of time:
  $("#joatu_modal .modal-header").children(':not([aria-label="close"])').remove()

  if title
    $("#joatu_modal .modal-header").append(title)

  $("#joatu_modal .modal-body").html(body)
