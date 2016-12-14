jQuery ->
  $("#image-uploader").S3Uploader
    progress_bar_target: $('#upload-container')
    before_add: (file) ->
      if !(file.type.match(/image.*/))
        alert 'File not supported!'
        false
      else if (file.size > 5000000)
        alert 'File size too large!'
        false
      else
        true

  $("#image-uploader").bind 's3_upload_failed', (e, content) ->
    alert content.filename + ' failed to upload'

  $('#image-uploader').bind "ajax:complete", (e, data, xhr) ->
    $("#image-list").append "<img src=" + data.responseJSON.url + " class='thumb' />"
    $('form #post-attachments').append "<input type='hidden' name='images[]' value='"+ data.responseJSON.id + "' />"

  $(".pictures").on "ajax:success", "div.image a.remove", (event, data, status, xhr) ->
    $(event.target).parent().fadeOut "slow", () ->
      $(this).remove()
  return
