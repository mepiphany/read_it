require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
    it "instantiates new object to the @user" do
      user = User.create(email: "mike@mike.com", password: "asdfasdf", password_confirmation: "asdfasdf")
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end


  describe "#create" do
    context "valid attributes" do
      def valid_request
        post :create, user: { email: "mike1@mike1.com",
                              password: "asdfasdf",
                              password_confirmation: "asdfasdf"}
      end
        it "creates a record in the database" do
          before_user_count = User.count
          valid_request
          after_user_count = User.count
          expect(after_user_count - before_user_count).to eq(1)
        end
        it "redirect to root_path" do
          valid_request
          expect(response).to redirect_to(root_path)
        end
        it "display flash notice" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "invalid attributes" do
        def invalid_request
          post :create, user: { email: "mike@mike.com",
                                password: "asdf",
                                password_confirmation: "asdf"}
        end
          it "does not create a record in the database" do
            before_user_count = User.count
            invalid_request
            after_user_count = User.count
            expect(after_user_count - before_user_count).to eq(0)
          end
          it "re-renders the page" do
            invalid_request
            expect(response).to render_template(:new)
          end
          it "display flash notice" do
            invalid_request
            expect(flash[:alert]).to be
          end
        end
      end
      
    end
