require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:article) {Article.create(title: "test_name", body: "test_body")}

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, article_id: article.id, comment: {title: "comment_test",
                                                        body: "body_test"}
      end
    it "creates record in the database" do
      comment_count_before = Comment.count
      valid_request
      comment_count_after = Comment.count
      expect(comment_count_after - comment_count_before).to eq(1)
    end
    it "renders show page" do
      valid_request
      expect(response).to redirect_to(article_path(article))
    end
    it "display flash notice" do
      valid_request
      expect(flash[:notice]).to be
    end
  end
    context "with invalid attributes" do
      def invalid_request
        post :create, article_id: article.id, comment: {title: "comment_test",
                                                        body: ""}
      end
      it "does not create a database record" do
        comment_count_before = Comment.count
        invalid_request
        comment_count_after = Comment.count
        expect(comment_count_before).to eq(comment_count_after)
      end
      it "renders show page" do
        invalid_request
        expect(response).to render_template("articles/show")
      end
      it "display flash notice" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end
  describe "#destroy" do

   it "destroy record from the database" do
     comment = Comment.create(title: "comment_test", body: "body_test", article_id: article.id)
     comment_count_before = Comment.count
     delete :destroy, article_id: article.id, id: comment.id
     comment_count_after = Comment.count
     expect(comment_count_after - comment_count_before).to eq(-1)
   end

   it "redirect to show page" do
     comment = Comment.create(title: "comment_test", body: "body_test", article_id: article.id)
     delete :destroy, article_id: article.id, id: comment.id
     expect(response).to redirect_to(article_path(article))
   end
   it "display notice" do
     comment = Comment.create(title: "comment_test", body: "body_test", article_id: article.id)
     delete :destroy, article_id: article.id, id: comment.id
     expect(flash[:notice]).to be
   end
  end
end
