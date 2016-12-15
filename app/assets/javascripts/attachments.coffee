jQuery ->
  content_type = /text.*|image.*|video.*|audio.*|.*pdf|.*xml|.*epub/

  $("#file-uploader").s3Uploader
    progress_bar_target: $('#file-upload-container')
    remove_failed_progress_bar: true
    click_submit_target: $('#file-uploader button.submit')
    before_add: (file) ->
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
    $('#file-upload-container').html ''

  $('#file-uploader input:file').change (evt) ->
    parentEl = $(this).parent()
    tgt = evt.target or window.event.srcElement
    files = tgt.files
    # FileReader support
    if FileReader and files and files.length
      fr = new FileReader
      fileType = files[0].type
      fr.onload = (e) ->
        if (fileType.match(content_type))
          $('#file-upload-container').append '<p>' + files[0].name + '</p>'
        return

      fr.readAsDataURL files[0]
    return

  $(".files").on "ajax:success", ".attachment a.remove", (event, data, status, xhr) ->
    $(event.target).parent().parent().fadeOut "slow", () ->
      $(this).remove()
  return