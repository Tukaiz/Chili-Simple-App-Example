## requires the package pdftk to be installed
$config = YAML.load_file(File.join(File.dirname(__FILE__), '../chili_config.yml'))
require 'open-uri'

module ChiliBackend

  class PrepareWorkflow
    @@workflow_path = $config['chili']['workflow_path']

# TODO: NEED TO determine
    def self.create_print_pdf(doc_id, application, user_id, unique_id)
      path = "#{@@workflow_path}/#{application}/#{user_id}/#{unique_id}/"
      file_name = "#{doc_id}.pdf"
      con = Chili::ChiliVdp.new

      # Generate the PDF
      xml_settings = '<item name="Default" id="2b71feda-90db-4bc8-a44a-4918cb8aa196" relativePath="" missingAdPlaceHolderColor="#FF00FF" missingAdPlaceHolder="False" missingEditPlaceHolder="False" includeLinks="False" includeGuides="False" includeTextRangeBorder="True" includePageMargins="True" includeFrameBorder="True" imageQuality="original" includeCropMarks="True" includeBleedMarks="True" includeImages="True" includeNonPrintingLayers="False" includeGrid="True" includeBleed="True" includeAdOverlays="False" includeSectionBreaks="False" includePageLabels="False" includeFrameInset="True" includeBaseLineGrid="True" includeSlug="True" includeAnnotations="False" outputSplitPages="1" layoutID="" createAllPages="True" pageRangeStart="1" userPassword="" ownerPassword="" pdfSubject="" pdfKeywords="" watermarkText="" pdfLayers="False" createSingleFile="True" createSpreads="False" serverOutputLocation="" slugLeft="" slugTop="" slugRight="" slugBottom="" bleedRight="3 mm" bleedTop="3 mm" bleedLeft="3 mm" useDocumentBleed="True" useDocumentSlug="True" optimizationOptions="" preflight_overrideDocumentSettings="False" preflight_minOutputResolution="72" preflight_minResizePercentage="70" preflight_maxResizePercentage="120" dataSourceIncludeBackgroundLayers="False" dataSourceCreateBackgroundPDF="True" dataSourceRowsPerPDF="1" dataSourceMaxRows="-1" dontDeleteExistingDirectory="False" collateOutputWidth="210mm" collateNumRows="3" collateNumCols="3" collateOutputHeight="297mm" collateColumnWidth="50mm" collateStartX="10mm" collateStartY="10mm" collateMarginX="10mm" allowExtractContent="True" collateMarginY="10mm" collateOutput="False" collateDrawPageBorder="False" collateIncludeFileHeader="False" missingAdSizePlaceHolderColor="#FF00FF" rgbSwatches="False" dropshadowQuality="150" missingEditPlaceHolderColor="#FF00FF" annotationBorderColor="#FF0000" annotationFillColor="#FFFFFF" annotationOpacity="50" linkBorderColor="#0000FF" dropshadowTextQuality="150" bleedBottom="3 mm" barWidthReduction="0 mm" markOffset="9pt" markWidth="0.5pt" dataSourceEngine="editor_cli" dataSourceNumConcurrent="3" dataSourceUnspecifiedContentType="variable_data" dataSourceIncludeGenerationLog="False" dataSourceUnspecifiedPageContentType="variable_data" outputIntentRegistryName="" outputIntentConditionIdentifier="" outputIntent="" pdfStandard="" pdfVersion="4" debugVtContent="False" watermarkType="" watermarkPdfAssetID="" watermarkPdfAnchor="top_left" pageRangeEnd="999999" watermarkPdfSize="original" convertBlacks="False" convertAnyK100="True" convertSystemBlack="True" convert0_0_0_100="True" convertBlackToC="63" convertBlackToK="100" convertBlackToY="51" convertBlackToM="52" debugDropShadowsWithoutBlur="False" missingAdSizePlaceHolder="False" pdfCreator="CHILI Publisher" pdfAuthor="CHILI Publisher" allowPrinting="True" allowModifyDocument="True" fastWebView="False" embedFonts="True" pdfTitle="" dataSourceCreate="False"><pdfvt_metaDataConfigItems/></item>'
      #xml_settings = '<item name="a1" id="94fc8224-b223-453a-a6d0-1ec1df8eab57" relativePath="" missingAdPlaceHolderColor="#FF00FF" missingAdPlaceHolder="False" missingEditPlaceHolder="False" includeLinks="False" includeGuides="False" includeTextRangeBorder="True" includePageMargins="True" includeFrameBorder="True" imageQuality="original" includeCropMarks="True" includeBleedMarks="True" includeImages="True" includeNonPrintingLayers="False" includeGrid="True" includeBleed="True" includeAdOverlays="False" includeSectionBreaks="False" includePageLabels="False" includeFrameInset="True" includeBaseLineGrid="True" includeSlug="True" includeAnnotations="False" outputSplitPages="1" layoutID="" createAllPages="True" pageRangeStart="1" userPassword="" ownerPassword="" pdfSubject="" pdfKeywords="" watermarkText="" pdfLayers="False" createSingleFile="True" createSpreads="True" serverOutputLocation="" slugLeft="5 mm" slugTop="5 mm" slugRight="5 mm" slugBottom="5 mm" bleedRight="3 mm" bleedTop="3 mm" bleedLeft="3 mm" useDocumentBleed="True" useDocumentSlug="True" optimizationOptions="" preflight_overrideDocumentSettings="False" preflight_minOutputResolution="72" preflight_minResizePercentage="70" preflight_maxResizePercentage="120" dataSourceIncludeBackgroundLayers="False" dataSourceCreateBackgroundPDF="True" dataSourceRowsPerPDF="1" dataSourceMaxRows="-1" dontDeleteExistingDirectory="False" collateOutputWidth="210mm" collateNumRows="3" collateNumCols="3" collateOutputHeight="297mm" collateColumnWidth="50mm" collateStartX="10mm" collateStartY="10mm" collateMarginX="10mm" allowExtractContent="True" collateMarginY="10mm" collateOutput="False" collateDrawPageBorder="False" collateIncludeFileHeader="False" missingAdSizePlaceHolderColor="#FF00FF" rgbSwatches="False" dropshadowQuality="150" missingEditPlaceHolderColor="#FF00FF" annotationBorderColor="#FF0000" annotationFillColor="#FFFFFF" annotationOpacity="50" linkBorderColor="#0000FF" dropshadowTextQuality="150" bleedBottom="3 mm" barWidthReduction="0 mm" markOffset="9pt" markWidth="0.5pt" dataSourceEngine="editor_cli" dataSourceNumConcurrent="3" dataSourceUnspecifiedContentType="variable_data" dataSourceIncludeGenerationLog="False" dataSourceUnspecifiedPageContentType="variable_data" outputIntentRegistryName="" outputIntentConditionIdentifier="" outputIntent="" pdfStandard="" pdfVersion="4" debugVtContent="False" watermarkType="" watermarkPdfAssetID="" watermarkPdfAnchor="top_left" pageRangeEnd="999999" watermarkPdfSize="original" convertBlacks="False" convertAnyK100="True" convertSystemBlack="True" convert0_0_0_100="True" convertBlackToC="63" convertBlackToK="100" convertBlackToY="51" convertBlackToM="52" debugDropShadowsWithoutBlur="False" missingAdSizePlaceHolder="False" pdfCreator="CHILI Publisher" pdfAuthor="CHILI Publisher" allowPrinting="True" allowModifyDocument="True" fastWebView="False" embedFonts="True" pdfTitle="" dataSourceCreate="False"><pdfvt_metaDataConfigItems/></item>'

      task_id = con.export_pdf(doc_id, xml_settings)
      while task = con.task_status(task_id) and task.finished == 'False'; end
      url = ChiliService::PreviewResult.parse(task.result).url

      #create the dirs
      r1 = system("mkdir #{@@workflow_path}/#{application}")
      r2 = system("mkdir #{@@workflow_path}/#{application}/#{user_id}")
      r3 = system("mkdir #{@@workflow_path}/#{application}/#{user_id}/#{unique_id}")

#binding.pry

      # Copy the PDF to the workflow path
      open("#{path}#{file_name}", 'wb') do |file|
        file << open(url).read
      end

      # split the files
      ChiliBackend::SplitDoc.extract(path, file_name)

    end

  end

  class DSTools

    # Pass in an array of ds field names and the folder name of the split up pdf
    # RETURNS: HASH of the doc fields and values
    def self.assign_data(variable_names, dir)
      variable_data = {}
      variable_names.each do |vn|
        num = vn.match(/_\d*\z/).to_s.gsub('_', '')
        variable_data[vn.to_sym] = "#{dir}_#{num}.pdf"
      end
      variable_data
    end

    # Pass in array of ds field name and an array of filenames
    # RETURNS: xml for print (PA)
    def self.batch_files(variable_names, file_arr)
      xml ='<?xml version="1.0" encoding="UTF-8"?>
              <COMMAND>
                <Parameters>
                  <FandV FieldValue="" FieldName="ImpositionName"/>
                  <FandV FieldValue="1" FieldName="IMPPREVIEW"/>
                  <FandV FieldValue="PDF" FieldName="OUTPUT"/>
                </Parameters>
                <TableRows>'

      file_arr.each do |f|
        xml += '<Fields>'
        vars = DSTools::assign_data(variable_names, f.gsub('.pdf', ''))
        vars.each do |index, val|
          xml += '<FandV FieldName="'+index.to_s+'" FieldValue="'+val+'" />'
        end
        xml += '</Fields>'
      end

      xml += '</TableRows>
            </COMMAND>'
      xml
    end


  end


  class SplitDoc

    # Turn a pdf into single page pdfs in a unique folder
    # RETURNS: the FOLDER of new files
    def self.extract(path, file_name)
      # :pages => 1..10

      new_folder = file_name.gsub('.pdf', '')
      new_dir = path + new_folder
      Docsplit.extract_pages((path+file_name), :output=>(new_dir))
      return new_folder
    end

  end

end