class TopsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  
  def index
  end
end
