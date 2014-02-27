module Chili
  class ChiliVdp

    # ChiliVdp.new.authenticate
    attr_accessor :url, :client, :data, :result, :user, :password, :session_id

    def initialize(server = "http://chili.my.dev/CHILI/main.asmx?wsdl")
      @url    = server
      @client = Savon::Client.new @url
      self.authenticate
      @data   = {}
    end

    def authenticate
      @result = @client.generate_api_key do |soap|
       soap.body = {
          "wsdl:environmentNameOrURL"=>"tukaiz",
          "wsdl:userName"=>"tukaiz",
          "wsdl:password" =>"tukaiz_dem0"
        }
      end

      # puts @result.to_hash[:generate_api_key_response][:generate_api_key_result].inspect
      # puts @result.to_hash[:generate_api_key_response][:generate_api_key_result].split(/key=\"/)[1].split('"')[0]
      self.session_id = @result.to_hash[:generate_api_key_response][:generate_api_key_result].split(/key=\"/)[1].split('"')[0]
    end

    def resource_list
      @result = @client.request(:resource_list) do
        soap.body ={"apiKey" => @session_id}
      end
      @result.to_hash
    end

    def get_resource_tree
      @result = @client.resource_get_tree do |soap|
        soap.body = {"wsdl:apiKey" => @session_id,
                             "wsdl:resourceName"=>"Documents",
                             "wsdl:parentFolder"=>"",
                             "wsdl:includeSubDirectories"=>true,
                             "wsdl:includeFiles" => true}
      end
      @result.to_hash
    end

    def get_document_editor
      @result = @client.generate_api_key do |soap|
        soap.body = { "wsdl:apiKey" => @session_id,
                      "wsdl:itemID" => "9f43d02b-ffd5-42d5-9701-bb40cedcbc1f"
        }
      end
    end

    def get_document_url(document_id, workspace_id=nil, view_prefs=nil, constraints_id=nil)
      options = {"wsdl:apiKey" => @session_id,
                 "wsdl:itemID" => document_id}

      options["wsdl:workSpaceID"] = workspace_id if workspace_id
      options["wsdl:viewPrefsID"] = view_prefs if view_prefs
      options["wsdl:constraintsID"] = constraints_id if constraints_id
      @result = @client.document_get_editor_url do |soap|
        soap.body = options
      end
      @result.to_hash[:document_get_editor_url_response][:document_get_editor_url_result].split(/url=\"/)[1].split('"')[0]

    end


  end
end

