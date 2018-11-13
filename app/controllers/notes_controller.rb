# frozen_string_literal: true

class NotesController < BaseController
  def index
    @notes = Note.order(created_at: :desc).includes(:user)
    render :index, status: :ok
  end

  def create
    @note = current_user.notes.create!(create_params)
    NotificationBroadcaster.new($redis, render_to_string(formats: "json"), current_user).call
    render :create, status: :created
  end

  private

    def create_params
      params.require(:note).permit(:body)
    end
end
