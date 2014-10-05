require 'chartkick'
require 'github_commit'
require 'owner_repos'

class GraphController < ApplicationController
 # def line_graph
  #  cs = GithubCommit.generate_commits(params[:owner], params[:repo_name])
   # @repo_name = params[:repo_name]
    #@additions = cs.map{|c| c.additions}
    #@deletions = cs.map{|c| c.deletions}
    #@dates  = cs.map{|c| c.date}
  #end


  #### select the graph type ####
  def index
    @owner_name = params[:owner]
    @repo_name = params[:repo_name]

    @repo_option = params[:repo]
    @user_option = params[:user]
    @org_option = params[:org]


    if @repo_option != nil then
      choose_repo_graph
    elsif @user_option != nil then
      choose_user_graph
    elsif @org_option != nil then
      choose_org_graph
    else
      #issue
      puts "problem choosing radio button"
    end
  end


  #### call the exact graph option based on type #### 
 

  def choose_repo_graph
    case @repo_option
    when "add_sub"
      repo_add_sub
    when "commit_per_user"
      repo_per_user
    when "commit_total"
      repo_total
    else
      #problem
      puts "problem choosing repository graph function"
    end
  end


  def choose_user_graph
    case @user_option
    when "commit_per_proj"
      owner_compare
    when "commit_total"
      user_total
    when "compare"
      compare
    else
      #problem
      puts "problem choosing user graph function"
    end
  end

  def choose_org_graph
    case @repo_option
    when "commit_per_proj"
      owner_compare
    when "commit_total"
      org_total
    else
      #problem
      puts "problem choosing organization graph function"
    end
  end
        

  #### controller actions, has an associated view ####

  def repo_add_sub
    # one repository, additions and deletions over time
    cs = GithubCommit.generate_commits(@owner_name, @repo_name)
    @additions = cs.map{|c| c.additions}
    @deletions = cs.map{|c| c.deletions}
    @dates  = cs.map{|c| c.date}
  end

  def repo_per_user 
    # one repository, one line per contributor - points are commits
    # model needs functionality that creates a hash of arrays of commits (1 array = all commits of 1 contributor) 
    # keys of has is the name of the 
    # put in instance variable and pass along to view
    @contributor_commits = GithubCommit.generate_names_hash(@owner_name, @repo_name)
    @dates = GithubCommit.generate_commits(@owner_name, @repo_name).map{|c| c.date}
  end
  
  def repo_total
    #one repository, total changes over time
    cs = GithubCommit.generate_commits(@owner_name, @repo_name)
    @changes = cs.map{|c| c.changes}
    @dates = cs.map{|c| c.dates}
  end

  ## <<CHALLENGE PROBLEMS>> ##
  def user_total
    #user's resposities, maps average commits over time
    cs = GithubCommit.generate_commits(@owner_name, @repo_name)
    @dates = cs.map{|c| c.dates}
  end
  
  def org_total
    #one organization, each point is a total of commits at that point in time
    @repos = OwnerRepos.generate_owner_repo_commits(@owner_name)
    #sum up all commits at the same time
    @changes = @repos.map{|r| r.map{|c| c.changes}} 
      
    @dates = cs.map{|c| c.dates}
  end
  ## /<<CHALLENGE PROBLEMS>> ##
  
  def compare
    @repo_owners_names = params[:repos].split(';')
    @repos = @repo_owners_names.map{|s| s.split(':')}.map{|r| GithubCommit.generate_commits(r[0], r[1])}
  end
  
  def owner_compare
    @names = OwnerRepos.generate_owner_repo_names(@owner_name)
    @repos = OwnerRepos.generate_owner_repo_commits(@owner_name)
  end
end
