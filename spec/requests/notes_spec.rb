require 'rails_helper'

describe "Notes" do
  describe "#index" do
    subject(:response_note) { response_data["notes"].first }
    subject(:note) { Note.find(response_data["notes"].first["id"]) }

    let(:user) { create :user }
    let(:user2) { create :user }
    sign_in(:user)

    before do
      create_list :note, 5, user: user
      create_list :note, 5, user: user2

      get "/notes"
    end

    it "returns all of the notes" do
      expect(response_data["notes"].count).to eq(Note.count)
    end

    it "responds with record's attributes" do
      expect(response_note).to include(note.slice(:id, :body, :user_id))
    end

    it "responds with record's created_at time" do
      expect(Time.parse(response_note["created_at"])).to be_within(1.second).of(note.created_at)
    end

    it "responds with author user email" do
      expect(response_note["user"]["email"]).to eq(note.user.email)
    end

    it "responds with author name" do
      expect(response_note["user"]["name"]).to eq(note.user.name)
    end

    it "responds with author image" do
      expect(response_note["user"]["image"]).to eq(note.user.image)
    end
  end

  describe "#create" do
    subject(:user) { create :user }
    sign_in(:user)

    context "when correct params" do
      let(:params) { { note: { body: Faker::Food.description } } }

      before do
        @other_user = create :user
        @other_user.create_new_auth_token
        allow($redis).to receive(:publish)
        post "/notes", params: params
      end

      it "responds with status created" do
        expect(response).to have_http_status(:created)
      end

      it "responds with created record" do
        expect(response_data["note"]["body"]).to eq(params[:note][:body])
      end

      it "creates a note for user" do
        expect(user.notes.first).to be_present
      end

      it "sends notification to other user" do
        expect($redis).to have_received(:publish).with(@other_user.tokens.keys.first, kind_of(String))
      end

      it "doesn't send notification to creator" do
        expect($redis).not_to have_received(:publish).with(user.tokens.keys.first, anything)
      end
    end
  end
end
