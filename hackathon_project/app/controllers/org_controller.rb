class OrgController < ApplicationController
  def index
  end

  def show 
    @owner_name = params[:id]

    rs = OwnerRepos.generate_owner_repo_commits(@owner_name)
    @datas = []

    (0..rs.size-1).each do |n|
      rs[n].each do |c|
        @datas[n] = [c.date, c.changes]
      end
    end

    @names = OwnerRepos.generate_owner_repo_names(@owner_name)

    @lines = []
    (0..(@names.size-1)).each do |i|
      @lines[i] = {name: @names[i], data: @datas[i]}
    end
    
  end

#  def show
#    @owner_name = params[:id]
#    repos = OwnerRepos.generate_owner_repo_commits(@owner_name)
#    render json: repos
#  end
end
