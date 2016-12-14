jQuery ->
  $("#file-uploader").S3Uploader
    progress_bar_target: $('#file-upload-container')
    before_add: (file) ->
      content_type = /text.*|image.*|video.*|audio.*|.*pdf|.*xml|.*epub/
      if !(file.type.match(content_type))
        alert 'File not supported!'
        false
      else if (file.size > 10000000)
        alert 'File size too large!'
        false
      else
        true

  $("#file-uploader").bind 's3_upload_failed', (e, content) ->
    alert content.filename + ' failed to upload'

  $('#file-uploader').bind "ajax:complete", (e, data, xhr) ->
    $("#file-list").append "<p>" + data.responseJSON.url + "<p/>"
    $('form #post-attachments').append "<input type='hidden' name='attachments[]' value='"+ data.responseJSON.id + "' />"

  $(".files").on "ajax:success", ".attachment a.remove", (event, data, status, xhr) ->
    $(event.target).parent().parent().fadeOut "slow", () ->
      $(this).remove()
  return