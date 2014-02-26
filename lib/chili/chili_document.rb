module Chili
  class ChiliDocument
    # Chili Document Objects
    # This is an object used to store information about the chili document
    # 
    attr_accessor :name, :id, :icon, :url

    def initialize(options={})

      @name = options[:name] || ""
      @id   = options[:id] || ""
      @icon = options[:icon] || ""
      @url = options[:url] || ""

    end
  end
end
