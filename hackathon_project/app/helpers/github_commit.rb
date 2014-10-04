require 'open-uri'
require 'json'

Token = 'ae8911808ca7162e61ab46bdc79bd7d2e3fe41b5' # this probably shouldn't be hardcoded, change this later

module GH
  class GithubCommit
    attr_accessor :date
    attr_accessor :name
    attr_accessor :url
    attr_accessor :json
    
    def generate_json!
      @json = JSON.parse(open(url).read)
    end
    
    def additions
      @json['stats']['additions']
    end
    
    def deletions
      @json['stats']['deletions']
    end
    
    def total
      @json['stats']['total']
    end
    
    # Example: generate_commits('OHIOhackathon2014', 'ProjectMaize')
    def self.generate_commits(owner, repo_name)
      url = "https://api.github.com/repos/#{owner}/#{repo_name}/commits?access_token=#{Token}"
      parsed_json = JSON.parse open(url).read
      return parsed_json.map do |j|
        c = Commit.new
        c.date = j['commit']['committer']['date']
        c.name = j['commit']['committer']['name']
        c.url  = j['url'] + "?access_token=#{Token}"
        c.generate_json!
        c
      end
    end
  end
end
