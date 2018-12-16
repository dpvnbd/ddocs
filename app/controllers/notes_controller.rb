# frozen_string_literal: true

class NotesController < BaseController
  before_action :find_note, only: [:update, :destroy]

  def index
    @notes = Note.order(created_at: :desc).includes(:user)
    render :index, status: :ok
  end

  def create
    @note = current_user.notes.create!(create_params);
    NotificationBroadcaster.new($redis, render_to_string(formats: "json"), current_user).call
    render :create, status: :created
  end

  def update
    @note.update!(create_params)
    render :show, status: :ok
  end

  def destroy
    @note.destroy!
  end

  private

  def create_params
    params.require(:note).permit(:body)
  end

  def find_note
    @note = current_user.notes.find(params.require(:id))
  end
end
