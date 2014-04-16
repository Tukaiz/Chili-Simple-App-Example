namespace :chili do

  task :test_pdf_split => :environment do
    path = ''
    file_name = '161636_BoM_StPats_SAMPLEs.pdf'
    result = ChiliBackend::SplitDoc.extract(path, '161636_BoM_StPats_SAMPLEs.pdf')
    puts result
  end

  task :test_ds_data_creation => :environment do
    variable_names = ['page_1', 'page_2', 'page_3', 'page_4']
    dir = '161636_BoM_StPats_SAMPLEs'
    result = ChiliBackend::DSTools.assign_data(variable_names, dir)
    puts result
  end

  task :get_doc_tree => :environment do
    c = Chili::ChiliVdp.new
    result = c.get_resource_tree
binding.pry
    puts result
  end



  task :test_backend_workflow => :environment do
    #doc_id = 'd47b5b43-1b7c-4292-a4fa-4b4394c9d2b8'  #tmp....wanted 1 (15)
    doc_id = '22908f24-522d-4fda-8e6c-8618a31c0a39'
    application = 'test_app'
    user_id = '34234234'
    unique_id = '768678'

    ChiliBackend::PrepareWorkflow.create_print_pdf(doc_id, application, user_id, unique_id, '/mnt/heap1/chili_backend')
  end


  task :test_batching_data => :environment do
    variable_names = ['page_1', 'page_2']
    file_arr = []
    (1..100).each do |i|
      file_arr += ["test_app\\34234234\\768678\\22908f24-522d-4fda-8e6c-8618a31c0a39_#{i}\\22908f24-522d-4fda-8e6c-8618a31c0a39_#{i}.pdf"]
    end
    xml = ChiliBackend::DSTools.batch_files(variable_names, file_arr)
    open("test_data.xml", 'wb') do |file|
      file << xml
    end
puts xml
  end


  task :clone_files_for_test => :environment do
    (1..100).each do |i|
      system("mkdir /mnt/heap1/chili_backend/test_app/34234234/768678/22908f24-522d-4fda-8e6c-8618a31c0a39_#{i}")
      system("cp -rf /mnt/heap1/chili_backend/test_app/34234234/768678/22908f24-522d-4fda-8e6c-8618a31c0a39/22908f24-522d-4fda-8e6c-8618a31c0a39_1.pdf /mnt/heap1/chili_backend/test_app/34234234/768678/22908f24-522d-4fda-8e6c-8618a31c0a39_#{i}/22908f24-522d-4fda-8e6c-8618a31c0a39_#{i}_1.pdf")
      system("cp -rf /mnt/heap1/chili_backend/test_app/34234234/768678/22908f24-522d-4fda-8e6c-8618a31c0a39/22908f24-522d-4fda-8e6c-8618a31c0a39_2.pdf /mnt/heap1/chili_backend/test_app/34234234/768678/22908f24-522d-4fda-8e6c-8618a31c0a39_#{i}/22908f24-522d-4fda-8e6c-8618a31c0a39_#{i}_2.pdf")
    end
  end

  # 161899_RIMS_pcard_ChiliTest.pdf
  task :setup_for_vdp_test => :environment do
    path = '/mnt/heap1/chili_backend/'
    file_name = '161899_RIMS_pcard_ChiliTest.pdf'
    ChiliBackend::SplitDoc::extract(path, file_name)
  end

  task :test_batching_data_vdp => :environment do
    variable_names = ['page_1', 'page_2']
    file_arr = []
    (1..100).step(2) do |i|
      file_arr += ["161899_RIMS_pcard_ChiliTest\\161899_RIMS_pcard_ChiliTest_#{i}.pdf"]
    end
    xml = ChiliBackend::DSTools.batch_files(variable_names, file_arr, true)
    open("test_vpd_data.xml", 'wb') do |file|
      file << xml
    end
  end

  task :test_buisness_card_sheet => :environment do
    variable_names = ['page_1', 'page_2']
    file_arr = ['buis_card\\file.pdf']
    xml = ChiliBackend::DSTools.batch_files(variable_names, file_arr, false, 10)
    open("test_bcard_data.xml", 'wb') do |file|
      file << xml
    end
puts xml
  end


  task :test_data_file_upload => :environment do
    data_source_id = '0de43b77-5d00-48d0-b128-5e4c43f7ab85'
    file_name = 'Test File 3'

    f = File.open(Rails.root.to_path+'/test_file.xlsx', "r")
    data = f.read
    f.close

    c = Chili::ChiliVdp.new.upload_data_file(data_source_id, file_name, data)
puts c
  end


end
