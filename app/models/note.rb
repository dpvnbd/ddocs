class Note < ApplicationRecord
  belongs_to :user

  after_create_commit :broadcast_message

  validates :body, presence: true

  private

  def broadcast_message
    NotesBroadcastJob.perform_later(self)
  end
end
