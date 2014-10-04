require 'github_commit'

class GitStuffController < ApplicationController
  def text
    @cs = GithubCommit.generate_commits(params[:owner], params[:repo_name])
  end
end

#'OHIOhackathon2014', 'ProjectMaize'
