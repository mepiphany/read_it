require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "#Index" do
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

  describe "#show" do
    it "find the object by its id and sets to @article variable" do
      article = Article.create(title: "show_test", body: "body_test")
      get :show, id: article.id
      expect(assigns(:article)).to eq(article)

    end
    it "renders the show page" do
      article = Article.create(title: "show_test", body: "body_test")
      get :show, id: article.id
      expect(response).to render_template(:show)
    end
    it "raises an error if the id passed doesn't match the record in the DB" do
      article = Article.create(title: "show_test", body: "body_test")
      expect { get :show, id: 23423 }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#edit" do
    it "renders edit page" do
      article = Article.create(title: "title", body: "body")
      get :edit, id: article
      expect(response).to render_template(:edit)
    end
    it "finds the article by the id and set it to @article" do
      article = Article.create(title: "title", body: "body")
      get :edit, id: article
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "#update" do
    context "with valid attributes" do
      it "updates with new information" do
        article = Article.create(title: "update_test", body: "update_body")
        patch :update, id: article.id, article: {title: "updated!"}
        expect(article.reload.title).to eq("updated!")
      end
      it "redirect_to show page" do
        article = Article.create(title: "update_test", body: "update_body")
        patch :update, id: article.id, article: {title: "updated!"}
        article = article.reload
        expect(response).to redirect_to(article_path(article))
      end
      it "display flash notice" do
        article = Article.create(title: "update_test", body: "update_body")
        patch :update, id: article.id, article: {title: "updated!"}
        expect(flash[:notice]).to be
      end
    end

    context "with invalid attributes" do
      it "does not update information" do
        article = Article.create(title: "update_test", body: "update_body")
        patch :update, id: article.id, article: {title: "asdfsadfsadfsdafdsafsdafsdafsdaf"}
        expect(article.reload.title).to_not eq("asdfsadfsadfsdafdsafsdafsdafsdaf")
      end
      it "renders edit page" do
        article = Article.create(title: "update_test", body: "update_body")
        patch :update, id: article.id, article: {title: "asdfsadfsadfsdafdsafsdafsdafsdaf"}
        expect(response).to render_template(:edit)
      end
      it "display flash notice" do
        article = Article.create(title: "update_test", body: "update_body")
        patch :update, id: article.id, article: {title: "asdfsadfsadfsdafdsafsdafsdafsdaf"}
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    it "record destroyed from the database" do
      article = Article.create(title: "delete_test", body: "delete_test")
      article_count_before = Article.count
      delete :destroy, id: article
      article_count_after = Article.count
      expect(article_count_after - article_count_before).to eq(-1)
    end
    it "redirect to index page" do
      article = Article.create(title: "delete_test", body: "delete_test")
      delete :destroy, id: article
      expect(response).to redirect_to(articles_path)
    end
    it "display flash notice" do
      article = Article.create(title: "delete_test", body: "delete_test")
      delete :destroy, id: article
      expect(flash[:notice]).to be
    end
  end
end
