class OrgController < ApplicationController
  def index
  end

  def show 
    @owner_name = params[:id]

    @names = OwnerRepos.generate_owner_repo_names(@owner_name)
    @repos = OwnerRepos.generate_owner_repo_commits(@owner_name)

    @lines = @repos.map {|r|
      {name: @names[@repos.index(r)], data: r.map{|c|
          c.date}.zip(r.map{|c| c.changes})}}    
  end
  
#  def show
#    @owner_name = params[:id]
#    repos = OwnerRepos.generate_owner_repo_commits(@owner_name)
#    render json: repos
#  end
end
