class PostsController < ApplicationController
  before_action :find_event, only: [:new, :create, :index]

  def index
    @posts = @event.posts
  end
  
  def new
    @post = @event.posts.build
  end

  def create
    @post = @event.posts.build(post_params)
    if @post.save
      redirect_to event_post_path(@event,@post), notice: 'proposal saved'
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
  
  def find_event
    @event = Event.find(params[:event_id])
  end

end
