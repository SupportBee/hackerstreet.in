# SearchController demonstrates how to do a Swiftype search on your
# server (as opposed to using the JavaScript).
#
# It is not linked to in the app, but you can visit it at /search
class SearchController < ApplicationController
  def search
    if params[:q]
      client = Swiftype::Easy.new
      @results = client.search('hackeronrails', params[:q], {:per_page => '10', :page => params[:page] || 1})
      @post_results = @results['story']
    end
  end
end
