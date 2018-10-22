# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
  $notes = $('#notes')
  $new_message_form = $('#new-note')
  $new_message_body = $new_message_form.find('#note-body')


  App.notes = App.cable.subscriptions.create {
    channel: "NotesChannel"
  },
    connected: ->

    disconnected: ->

    received: (data) ->
      if data['note']
        $new_message_body.val('')
        $notes.prepend data['note']

    create_note: (body) ->
      @perform 'create_note', body: body

    $new_message_form.submit (e) ->
      $this = $(this)
      note_body = $new_message_body.val()
      console.log('note', note_body)
      if $.trim(note_body).length > 0
        App.notes.create_note note_body
      e.preventDefault()
      return false