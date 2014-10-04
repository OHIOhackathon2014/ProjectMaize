class WelcomeController < ApplicationController
  def index
    render js: "javascript file location here"
  end
end
