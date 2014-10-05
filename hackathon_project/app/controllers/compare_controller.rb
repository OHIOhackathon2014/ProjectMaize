class CompareController < ApplicationController
    
    def compare
        @repo_owners_names = params[:repos].split(';')
        @repos = @repo_owners_names.map{|s| s.split(':')}.map{|r| GithubCommit.generate_commits(r[0], r[1])}
        
    end
end
