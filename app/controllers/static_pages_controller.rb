class StaticPagesController < ApplicationController
  include SessionsHelper

  def home
    if logged_in?
      redirect_to tops_path
    end
  end

end