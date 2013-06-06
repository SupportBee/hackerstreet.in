class CreateOrUpdateSwiftypeDocumentJob < Struct.new(:story_id)
  def perform
    story = Story.find(story_id)
    client = Swiftype::Easy.new
    client.create_or_update_document(ENV['SWIFTYPE_ENGINE_SLUG'],
                                     Story.model_name.downcase,
                                     {:external_id => story.id,
                                       :fields => [{:name => 'title', :value => story.title, :type => 'string'},
                                                   {:name => 'url', :value => story.url, :type => 'enum'},
                                                   {:name => 'created_at', :value => story.created_at.iso8601, :type => 'date'}]})
  end
end
