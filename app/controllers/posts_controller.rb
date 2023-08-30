class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @posts = Post.order(created_at: :desc)
    end

    def new
        @post = Post.new
    end

    def edit
        post
    end
    
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
          flash[:success] = "Object successfully created"
          redirect_to posts_path
        else
          flash[:error] = "Something went wrong"
          render 'new', status: :unprocessable_entity
        end
    end

    def update
        if post.update(post_params)
            redirect_to posts_url
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def show
        post
    end
    
        
    
    private

    def post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :content)
    end
    
    
end
