#require 'github_commit'
require 'open-uri'
require 'json'

class OwnerRepos
  def self.generate_owner_repo_names(owner)
    JSON.parse(open("https://api.github.com/users/#{owner}/repos").read).map{|r| r['name']}
  end

  def self.generate_owner_repo_commits(owner)
    self.generate_owner_repo_names(owner).map{|name| GithubCommit.generate_commits(owner, name)}
  end
end
