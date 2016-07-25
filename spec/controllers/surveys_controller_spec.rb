require 'rails_helper'

RSpec.describe SurveysController, type: :controller do

  let(:user) { create :user }

  let(:valid_params) { 
    {
    responder: user,
    hiring: false,
    glutFree: true,
    musicians: true,
    lgbt: true,
    localFood: false,
    minorityOwned: true,
    livWage: false,
    petFriend: true,
    artsCrafts: false,
    charNonprof: true,
    sustain: true,
    veganPeta: false,
  }
  }

  describe "POST #create" do
    it "creates a new survey" do

      set_auth_header user

      expect { Survey.create! valid_params }.to change(Survey, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "get #show" do
    it "returns an individual user or business survey" do

      set_auth_header user

      survey = Survey.create! valid_params

      get :show 

      expect(response).to have_http_status(:ok)
      expect( parsed_response["responder_id"] ).to eq(user.id)

    end
  end

  describe "get #matches" do
    it "returns an array of businesses that match the user survey on at least one attribute" do

      set_auth_header user

      user_survey = Survey.create! valid_params

      10.times do
        FactoryGirl.create(:survey)
      end

      get :matches

      expect(response).to have_http_status(:ok)
      expect(parsed_response.class).to eq(Array)
    end
  end

end
