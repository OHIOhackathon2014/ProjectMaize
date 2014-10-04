require 'chartkick'
require 'github_commit'

LogarithmicBreakpoint = 1000

class GraphController < ApplicationController
  def line_graph
    @cs = GithubCommit.generate_commits(params[:owner], params[:repo_name])
    @additions = @cs.map{|c| c.additions}
    @deletions = @cs.map{|c| c.deletions}
    @dates  = @cs.map{|c| c.date}
  end
end
