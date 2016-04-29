require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    it "doesn't allow creating a article with no title" do
      # Given: new article with out any information
      article = Article.new(title: nil, body: "hello")
      # When: Validating article
      article_valid = article.valid?
      expect(article_valid).to eq(false)
    end

     it "doesn't allow creating a article with no body" do
       article = Article.new(title: "hello", body: nil)
       article_valid = article.valid?
       expect(article_valid).to eq(false)
     end
  end
end
