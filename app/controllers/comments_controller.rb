class CommentsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to event_post_path(@event, @post), notice: 'Saved' }
        format.js
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body,:post_id)
  end

end
