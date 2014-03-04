module ChiliService

  class ResourceTree
    include HappyMapper

    tag 'item'
    attribute :name, String
    attribute :doc_id, String, :tag => 'id'
    attribute :is_folder, Boolean, :tag => 'isFolder'
    has_many :documents, ChiliDoc::Document

  end

end