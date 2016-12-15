jQuery ->
  $("#image-uploader").s3Uploader
    progress_bar_target: $('#upload-container')
    remove_failed_progress_bar: true
    click_submit_target: $('#image-uploader button.submit')
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
    $('#upload-container').html ''

  fileTypes = ['jpg', 'jpeg', 'pjpeg', 'png', 'gif']

  $('input:file').change (evt) ->
    parentEl = $(this).parent()
    tgt = evt.target or window.event.srcElement
    files = tgt.files
    # FileReader support
    if FileReader and files and files.length
      fr = new FileReader
      extension = files[0].name.split('.').pop().toLowerCase()

      fr.onload = (e) ->
        success = fileTypes.indexOf(extension) > -1
        if success
          $('#upload-container').append '<img src="' + fr.result + '" class="thumb"/>'
        return

      fr.readAsDataURL files[0]
    return

  $(".pictures").on "ajax:success", "div.image a.remove", (event, data, status, xhr) ->
    $(event.target).parent().parent().fadeOut "slow", () ->
      $(this).remove()
  return
