class ChiliPublisherController < ApplicationController
  def home
    # get 10 most recent documents
    chili_connection = Chili::ChiliVdp.new
    response = chili_connection.get_resource_tree()
    raw_xml = response[:resource_get_tree_response][:resource_get_tree_result]
    @xml = Nokogiri::XML(raw_xml)

    items = @xml.xpath("//item[@isFolder='false']")

    @documents = items[0..10].map do |item|
      
      link = chili_connection.get_document_url(item.attribute('id'))

      Chili::ChiliDocument.new(
        :name=>item.attribute('name'),
        :id=>item.attribute('id'),
        :icon => item.attribute('iconURL'),
        :url => link
      )
    end
  end

  def search
  end

  def editor
    @url = params[:url]
  end


end
