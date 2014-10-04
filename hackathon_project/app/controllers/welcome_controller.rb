require 'chartkick'
require 'github_commit'

LogarithmicBreakpoint = 1000

class WelcomeController < ApplicationController
  def index
    @cs = GithubCommit.generate_commits(params[:owner], params[:repo_name])
  end

  def line_graph
    @cs = GithubCommit.generate_commits(params[:owner], params[:repo_name])
    @additions = @cs.map{|c| c.additions}
    @deletions = @cs.map{|c| c.deletions}
    @dates  = @cs.map{|c| c.date}
  end

  def compare
    @repo_owners_names = params[:repos].split(';')
    @repos = @repo_owners_names.map{|s| s.split(':')}.map{|r| GithubCommit.generate_commits(r[0], r[1])}
  end
end

#'OHIOhackathon2014', 'ProjectMaize'

