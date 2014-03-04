module ChiliDoc

  class GetDocVals
    include HappyMapper

    tag 'item'
    attribute :name, String
    attribute :value, String
    attribute :type, String
  end

  class Document
    include HappyMapper

    tag 'item'
    attribute :name, String
    attribute :doc_id, String, :tag => 'id'
    attribute :is_folder, Boolean, :tag => 'isFolder'
    attribute :icon_url, String, :tag => 'iconURL'
  end


end