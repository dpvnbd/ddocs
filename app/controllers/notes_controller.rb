class NotesController < BaseController
  def index
    @notes = Note.order(created_at: :desc).includes(:user)
    render :index, status: :ok
  end

  def create
    @note = current_user.notes.create!(create_params)
    render :create, status: :created
  end

  private

  def create_params
    params.require(:note).permit(:body)
  end
end
