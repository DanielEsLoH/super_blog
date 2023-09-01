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
        if post.user.email == current_user.email

        else
            redirect_to posts_path, alert: "No tienes permisos para editar este post."
        end
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
        if post.user.email == current_user.email
            if post.update(post_params)
                redirect_to posts_url, notice: "El post ha sido actualizado exitosamente."
            else
                render :edit, status: :unprocessable_entity
            end
        else
            redirect_to posts_path, alert: "No tienes permisos para editar este post."
        end
    end

    def show
        post
    end

    def destroy
        post
        if post.user.email == current_user.email
            post.destroy
            flash[:notice] = 'El post ha sido eliminado exitosamente.'
            redirect_to posts_path
        else
            flash[:notice] = "No tienes permisos para eliminar este post."
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
