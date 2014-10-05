class OrgController < ApplicationController
  def index
  end

  def show
    @org_name = params[:id]
    repos = OwnerRepos.generate_owner_repo_commits(@owner_name)
    render json: repos
  end
end
