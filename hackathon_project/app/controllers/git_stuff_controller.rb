require 'github_commit'

class GitStuffController < ApplicationController
  def text
    @cs = GithubCommit.generate_commits('OHIOhackathon2014', 'ProjectMaize')
  end
end
