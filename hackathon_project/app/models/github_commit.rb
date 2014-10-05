require 'open-uri'
require 'json'

TOKEN = 'a0896197c4eb46e6009d9ae5fdc6813f0c334b63' # this probably shouldn't be hardcoded, change this later
MAX = 1000 # hard cap on lines of code counted

class GithubCommit
  attr_accessor :name
  attr_accessor :url
  attr_accessor :json
  attr_accessor :date
  attr_accessor :repo
  attr_accessor :owner

  def generate_json!
    @json = JSON.parse(open(url).read)
  end
  
  def additions
    [@json['stats']['additions'], MAX].min
  end
  
  def deletions
    [@json['stats']['deletions'], MAX].min
  end
  
  def total
    [@json['stats']['total'], MAX].min
  end

  def changes
    #[@json['files'].map{|f| f['changes']}.reduce(:+), MAX].min
    total
  end
  
  def date_parse(d)
    @date = DateTime.parse(d).change(offset: -4)
  end
  
  # Example: generate_commits('OHIOhackathon2014', 'ProjectMaize')
  def self.generate_commits(owner, repo_name, start_date='')
    begin
      url = generate_commits_url(owner, repo_name)
      JSON.parse(open(url).read).map do |j|
        c = self.new
        c.date_parse j['commit']['committer']['date']
        c.name = j['commit']['committer']['name']
        c.url  = j['url'] + "?access_token=#{TOKEN}"
        c.repo = repo_name
        c.owner = owner
        c.generate_json!
        c
      end
    rescue OpenURI::HTTPError
      return []
    end
  end

  def self.generate_commits_url(owner, repo_name, start_date='')
    if start_date.empty?
      return "https://api.github.com/repos/#{owner}/#{repo_name}/commits?access_token=#{TOKEN}"
    else
      return "https://api.github.com/repos/#{owner}/#{repo_name}/commits?access_token=#{TOKEN}&since=#{start_date}"
    end
  end

  def self.generate_from_url(url)
    parts = url.split('/').last 2
    return generate_commits parts[0], parts[1]
  end

  def self.generate_names_hash(owner, repo_name)
    cs = generate_commits owner, repo_name
    names = cs.map{|c| c.name}.uniq
    h = {}
    names.each do |name|
      h[name] = cs.select{|c| c.name == name}
    end
  end
end
