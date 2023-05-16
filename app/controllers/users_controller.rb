class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :check_user_connected, only: [:show, :edit, :update, :destroy]
  
  def index
    @all_users = User.all
  end

  def show
    @user = User.find(params[:id].to_i)
  end 

  def new
    @user = User.new
  end

  def edit 
    @user = User.find(params[:id])
  end 

  def update
    @user = User.find(params[:id])

    if @user.update(last_name:params[:last_name],first_name:params[:first_name],description:params[:description]) 
      redirect_to user_path(params[:id], success_user_update:true) 
    else
      render 'edit' 
    end
  end 

  def destroy
    @user = User.find(params[:id])

    if @user.delete
      redirect_to events_path(success_user_delete:true) 
    end
  end 

  private

    def authenticate_user
      unless current_user
        redirect_to new_session_path(connexion_obligatoire:true)
      end
    end

    def check_user_connected
      unless current_user == User.find(params[:id])
        redirect_to user_session_path(connexion_obligatoire:true)
      end
    end
end
