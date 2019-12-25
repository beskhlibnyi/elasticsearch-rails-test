class Post < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings do
      indexes :author, type: :string
      indexes :title, type: :string, analyzer: :english
      indexes :body, type: :string, analyzer: :english
      indexes :tags, type: :string, analyzer: :english
      indexes :published, type: :boolean
    end
  end

  def self.search_published(query)
    self.search({
      query: {
        bool: {
          must: [
            {
              multi_match: {
               query: query,
                fields: [:author, :title, :body, :tags]
              }
            },
            {
              match: {
                published: true
              }
            }
          ]
        }
      }
    })
  end
end
