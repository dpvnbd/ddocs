class NotesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(note)
    ActionCable.server.broadcast 'notes_channel', note: render_message(note)
  end

  private

  def render_message(note)
    NotesController.render partial: 'notes/note', locals: {note: note}
  end
end