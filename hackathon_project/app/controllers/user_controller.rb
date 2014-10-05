class UserController < ApplicationController

  def index
  end

  def show
    @owner_name = params[:id]
    repos = OwnerRepos.generate_owner_repo_commits(@owner_name)
    render json: repos
  end

end
