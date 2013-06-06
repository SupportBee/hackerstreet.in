class DeleteSwiftypeDocumentJob < Struct.new(:story_id)
  def perform
    client = Swiftype::Easy.new
    client.destroy_document(ENV['SWIFTYPE_ENGINE_SLUG'], Story.model_name.downcase, story_id)
  end
end
