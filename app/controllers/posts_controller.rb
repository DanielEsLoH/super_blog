class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        ordered_posts = Post.order(created_at: :desc)
        @posts = ordered_posts.paginate(page: params[:page], per_page: 10)
    end

    def new
        @post = Post.new
    end

    def edit
        post
        if post.user.email == current_user.email

        else
            redirect_to posts_path, alert: t('posts.alert.edit')
        end
    end
    
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
          redirect_to posts_path, notice: t('posts.notice.create')
        else
          flash[:alert] = t('posts.alert.went_wrong')
          render 'new', status: :unprocessable_entity
        end
    end

    def update
        if post.user.email == current_user.email
            if post.update(post_params)
                redirect_to posts_url, notice: t('posts.notice.update')
            else
                flash[:alert] = t('posts.alert.went_wrong')
                render :edit, status: :unprocessable_entity
            end
        else
            redirect_to posts_path, alert: t('posts.alert.permission_edit')
        end
    end

    def show
        post
    end

    def destroy
        post
        if post.user.email == current_user.email
            post.destroy
            flash[:notice] = t('posts.notice.delete')
            redirect_to posts_path
        else
            flash[:alert] = t('posts.alert.delete')
            redirect_to posts_path
        end
    end
    
        
    
    private

    def post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :content)
    end
    
    
end
