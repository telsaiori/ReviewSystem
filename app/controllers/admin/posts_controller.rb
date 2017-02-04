class Admin::PostsController < ApplicationController
  before_action :find_event, except: [:all_posts, :del_posts_page]
  before_action :find_post, only: [:edit, :update, :destroy, :show]

  def index
    @posts = search(@event.posts.order('id'))
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

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_event_post_path(@event,@post), notice: 'Edited'
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to event_posts_path(@event), alert: 'Deleted'
  end

  def show
    @comment = Comment.new
  end

  def del_posts
    Post.destroy_all(id: params[:post_ids])
    redirect_to admin_event_posts_path(params[:event_id]), alert: 'Deleted'
  end

  def all_posts 
    @posts = Post.all.includes([:event, :user])
  end

  def del_posts_page
    Post.destroy_all(id: params[:post_ids])
    redirect_to all_posts_admin_posts_path, alert: 'Deleted'
  end

  private

  def post_params
    params.require(:admin_post).permit(:title, :body, :user_id)
  end
  
  def find_event
    @event = Admin::Event.find(params[:event_id])
  end

  def find_post
    @post = Admin::Post.includes([:comments]).find(params[:id])
  end

  def search(query)
    if params[:search_field]
      if params[:search_field] == "content"
        search_field = "body"
      elsif params[:search_field] == "title"
        search_field = "title"
      end
        if search_field
          if params[:search_type] == 'Like'
            query.where("#{search_field} ILIKE ?", "%#{params[:search_keyword]}%" )  
          else
            query.where("#{search_field} = ? ", "%#{params[:search_keyword]}%")
          end
        else
          if params[:search_type] == 'Like'
            users = User.where("email ILIKE ?", "%#{params[:search_keyword]}%")
            # users.map{ |user|user.posts }
            users.first.posts
          else
            posts.joins(:user).where(users: {email: params[:search_keyword]})
         end
       end
    else
      query
    end
  end

end