jQuery ->
  $(".posts").on "ajax:success", "div.caption a.remove", (event, data, status, xhr) ->
    $(event.target).parent().parent().parent().fadeOut "slow", () ->
      $(this).remove()