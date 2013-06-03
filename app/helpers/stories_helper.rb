module StoriesHelper
  def points_scored(story)
    score = pluralize story.score, 'point'
#    user = story.user.name
    age = time_ago_in_words story.created_at
    "#{score} #{age} ago"
  end
end
