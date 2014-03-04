module Chili
  class ChiliVdp
    #  hosts file settings for DEV
    # 127.0.0.1 my.dev
    # 206.152.228.225 chili.my.dev

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
          "wsdl:environmentNameOrURL" => "training",
          "wsdl:userName"             => "api",
          "wsdl:password"             => "api"
        }
      end

      # puts @result.to_hash[:generate_api_key_response][:generate_api_key_result].inspect
      # puts @result.to_hash[:generate_api_key_response][:generate_api_key_result].split(/key=\"/)[1].split('"')[0]
      self.session_id = @result.to_hash[:generate_api_key_response][:generate_api_key_result].split(/key=\"/)[1].split('"')[0]
    end

    def method_name

    end

    def resource_list
      @result = @client.request(:resource_list) do
        soap.body = {"apiKey" => @session_id}
      end
      @result.to_hash
    end

    def get_resource_tree
      hash = { "wsdl:apiKey"                => @session_id,
               "wsdl:resourceName"          => "Documents",
               "wsdl:parentFolder"          => "",
               "wsdl:includeSubDirectories" => true,
               "wsdl:includeFiles"          => true }

      result = send_msg('resource_get_tree', hash, ChiliService::ResourceTree)
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

      options["wsdl:workSpaceID"]   = workspace_id if workspace_id
      options["wsdl:viewPrefsID"]   = view_prefs if view_prefs
      options["wsdl:constraintsID"] = constraints_id if constraints_id
      @result = @client.document_get_editor_url do |soap|
        soap.body = options
      end
      @result.to_hash[:document_get_editor_url_response][:document_get_editor_url_result].split(/url=\"/)[1].split('"')[0]

    end

    def set_workspace_admin(yes_or_no)
      @result = @client.set_workspace_administration do |soap|
        soap.body = { "wsdl:apiKey"                     => @session_id,
                      "wsdl:setWorkspaceAdministration" => yes_or_no
        }
      end
    end

    def get_document_values(document_id)
      hash = { "wsdl:apiKey" => @session_id,
               "wsdl:itemID" => document_id }
      result = send_msg('document_get_variable_values', hash, ChiliDoc::GetDocVals)
    end

    def get_document_definitions(document_id)
      @result = @client.document_get_variable_definitions do |soap|
        soap.body = { "wsdl:apiKey" => @session_id,
                      "wsdl:itemID" => document_id
        }
      end
      @result.to_hash[:document_get_variable_definitions_response][:document_get_variable_definitions_result]
    end

    def export_pdf(document_id, xml_settings)
      @result = @client.document_create_pdf do |soap|
        soap.body = { "wsdl:apiKey"       => @session_id,
                      "wsdl:itemID"       => document_id,
                      "wsdl:settingsXML"  => xml_settings,
                      "wsdl:taskPriority" => 1
        }
      end
      data = Nokogiri::XML(@result.to_hash[:document_create_pdf_response][:document_create_pdf_result])
      @task_id = data.children.first.attributes["id"].value
    end

    def task_status(task_id)
      @result = @client.task_get_status do |soap|
        soap.body = { "wsdl:apiKey" => @session_id,
                      "wsdl:taskID" => task_id
        }
      end
      binding.pry
    end


    def send_msg(action, hash_obj, return_obj = false)
      result = @client.send("#{action}".to_sym) do |soap|
        soap.body = hash_obj
      end
      if return_obj
        return return_obj.parse(result.to_hash["#{action}_response".to_sym]["#{action}_result".to_sym])
      else
        result
      end
    end

  end
end

