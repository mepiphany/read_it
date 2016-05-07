require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validation" do
    it "doesn't allow creating comment without a title" do
      comment = Comment.new(title: "", body: "test")
      comment_valid = comment.valid?
      expect(comment_valid).to eq(false)
    end
    it "doesn't allow creating comment without a body" do
      comment = Comment.new(title: "test", body: "")
      comment_valid = comment.valid?
      expect(comment_valid).to eq(false)
    end
    it "doesn't allow creating a article with same body" do
      comment_1 = Comment.create(title: "hello", body: "hi")
      comment = Comment.create(title: "hello", body: "hi")
      comment_valid = comment.valid?
      comment_1_valid = comment_1.valid?
      expect(comment_valid && comment_1_valid).to eq(false)
    end
  end
end
