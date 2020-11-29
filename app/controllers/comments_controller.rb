class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to item_path(@comment.item.id)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to item_path(@comment.item.id)
  end

  def edit
    @comment = Comment.find(params[:id])
    @comment.edit(delete_check:1)
    redirect_to item_path(@comment.item.id)
  end

private
  def comment_params
    params.require(:comment)
          .permit(:comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
