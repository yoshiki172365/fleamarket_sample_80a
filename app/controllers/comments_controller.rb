class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to item_path(@comment.item.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to item_path(@commet.item.id)
  end

  def edit
  end

private
  def comment_params
    params.require(:comment).permit(:comment,:item_id).merge(user_id: current_user.id)
  end
end
