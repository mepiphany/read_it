require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:article) {Article.create(title: "test_name", body: "test_body")}

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, article_id: article.id, comment: { title: "comment_test",
                                 body: "body_test"
                              }
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
      it "does not create a database record"
      it "renders show page"
      it "display flash notice"
    end

  end
end
