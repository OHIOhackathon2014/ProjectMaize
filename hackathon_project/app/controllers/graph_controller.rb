require 'chartkick'
require 'github_commit'
require 'owner_repos'

LogarithmicBreakpoint = 1000

class GraphController < ApplicationController
  def line_graph
    cs = GithubCommit.generate_commits(params[:owner], params[:repo_name])
    @repo_name = params[:repo_name]
    @additions = cs.map{|c| c.additions}
    @deletions = cs.map{|c| c.deletions}
    @dates  = cs.map{|c| c.date}
  end

  def compare
    @repo_owners_names = params[:repos].split(';')
    @repos = @repo_owners_names.map{|s| s.split(':')}.map{|r| GithubCommit.generate_commits(r[0], r[1])}
  end

  def owner_compare
    @names = OwnerRepos.generate_owner_repo_names(params[:owner])
    @repos = OwnerRepos.generate_owner_repo_commits(params[:owner])
  end
end
