$(document).on "page:change", (e)->
  $('[data-ride="scroll"]').click (e)->
    e.preventDefault()
    $("html,body").animate
        scrollTop: $(e.target.hash).offset().top
    , "slow"
