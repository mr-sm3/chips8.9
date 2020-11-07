require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe MoviesController do
  
  before do
    @thedictator = Movie.create(:id => 001, :title => "The Dictator", :director => "Admiral General Aladeen",
      :release_date => "26-Oct-1984", :rating => "G")
    @borat = Movie.create(:id => 002, :title => "Borat: Cultural Learnings of America for Make Benefit Glorious Nation of Kazakhstan",
    :director => "Borat Sagdiyev", :release_date => "01-Jan-2002", :rating => "PG-13")
    @alig = Movie.create(:id => 003, :title => "AliG in da town", :release_date => "03-Mar-2003",
    :rating => "R")
    
  end
  
  describe "GET paths search_directors" do
    it "happy path, when a movie does have a director. Very Naice." do
      get :search_directors, :id => 001
      expect(response).to render_template("search_directors")
    end
    
    it "sad path, when a movie does not have a director. Not Kool." do
      get :search_directors, :id => 003
      expect(response).to render_template("search_directors")
    end
  end
  
  describe "GET show" do
    it "renders the template" do
      get :show, :id => 001
      expect(response).to render_template("show")
    end
  end
  
  describe "Create Movie instance" do
    it "create and redirect" do
      post :create, :movie => {:title => "The Dictator 2"}
      response.should redirect_to("/movies")
    end
  end
  
  describe "Delete Movie instance" do
    it "delete and redirect" do
      delete :destroy, :id => 001
      #expect(response).to render_template("movies")
      response.should redirect_to("/movies")
    end
  end
end

    