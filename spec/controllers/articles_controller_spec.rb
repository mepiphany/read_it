require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "Get #Index" do
    it "renders the index template" do
      get :index
      expect(response).to be_success
    end
    it "loads all of the article into @articles" do
      article = Article.create(title: "aritcle_test", body: "article_body")
      article_1 = Article.create(title: "aritcle_test", body: "article_body")

      get :index

      expect(assigns(:articles)).to eq([article, article_1])
    end
  end

  describe "#new" do
    it "renders new page" do
      get :new
      expect(response).to render_template(:new)
    end
    it "instantiate new article object and assign it to @article" do
      article = Article.create(title: "title_test", body: "body_test")

      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, article: {
          title: "text",
          body: "body"
        }
      end

      it "create record in the database" do
        article_count_before = Article.count
        valid_request
        article_count_after = Article.count
        expect(article_count_after - article_count_before).to eq(1)
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

    context "with invalid attributes" do
      def invalid_request
        post :create, article: {
          title: "",
          body: "body"
        }
      end
      it "does not create a record in the database" do
        article_before = Article.count
        invalid_request
        article_after = Article.count
        expect(article_before).to eq(article_after)
      end
      it "render new page" do
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
