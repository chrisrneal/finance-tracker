class UsersController < ApplicationController

    def my_portfolio
        @user_stocks = current_user.stocks
        @user = current_user
    end
    
    def my_friends
        @friendships = current_user.friends
        @user = current_user
    end
    
    def search
        @users = User.search(params[:search_param])
        
        if @users
            @users = current_user.except_current_user(@users)
            render partial: 'friends/lookup'
        else
            render :not_found, nothing: :true
        end
    end
    
    def add_friend
        @friend = User.find(params[:friend])
        current_user.friendships.build(friend_id: @friend.id)
        
        if current_user.save
            flash[:success] = "Friend was successfully added"
            redirect_to my_friends_path
        else
            flash[:error] = "There was an error adding as a friend"
            redirect_to my_friends_path
        end
    end

end