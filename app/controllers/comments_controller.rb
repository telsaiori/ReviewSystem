class CommentsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to event_post_path(@event, @post), notice: 'Saved'
    else
      redirect_to :back
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body,:post_id)
  end

end
