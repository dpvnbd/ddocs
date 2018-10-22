class NotesChannel < ActionCable::Channel::Base
  def subscribed
    stream_from "notes_channel"
  end

  def unsubscribed
  end

  def create_note(data)
    current_user.notes.create(body: data['body'])
  end
end
