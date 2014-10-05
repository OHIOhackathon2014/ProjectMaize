class RepoController < ApplicationController
  
  before_filter :set_variables, except:[:index]

  def index
    #ask for repo name in view
  end


  def additions
    # one repository, additions and deletions over time
    cs = GithubCommits.generate_commit(@owner_name, @repo_name)
    
    @additions = []
    @deletions = []
    @dates = []

    @data = []

    cs.each do |c| 
      @deletions << [c.deletions, c.date]
      @additions << [c.additions, c.date]
    end
  end


  def show  
     cs = GithubCommit.generate_commits(@owner_name, @repo_name)
    @data = {} 

    cs.each do |c|
      i = [c.changes, c.date]
      if params[:user_group] 
        @data[c.name] ||= []
        @data[c.name] << i
      else
        @data[:total] ||= []
        @data[:total] << i
      end
    end
    #change the shape of the data so that kick charts will take it
    @chart_data = @data.reduce([]) do |out, (k, v)|
      out << {name: k, data: v}
    end
    
  end

  def commits
    #one repository, total changes over time
    cs = GithubCommit.generate_commits(@owner_name, @repo_name)
    @changes = cs.map{|c| c.changes}
    @dates = cs.map{|c| c.dates}

    @data = []

    cs.each do |c| 
      @data << [c.changes, c.date]
    end
  end

  def commits_by_user
  end

  private
  def set_variables
    @owner_name = params[:id]
    @repo_name = params[:repo]
  end
end






