class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    @comment.article = @article
    if @comment.save
      redirect_to article_path(@article), notice: "comment created!"
    else
      flash[:alert] = "Comment wasn't created!"
      render :new
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to article_path(@article), notice: "comment deleted!"
    end
  end


  private

  def comment_params
    params.require(:comment).permit([:title, :body, :article_id])
  end

end
