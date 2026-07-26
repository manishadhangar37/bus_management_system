class HomeController < ApplicationController
      skip_before_action  :check_authenticate_token

  def index
  end
  
end
