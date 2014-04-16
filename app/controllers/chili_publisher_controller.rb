class ChiliPublisherController < ApplicationController
  before_filter :initialize_chili_vdp

  # def home
    # # get 10 most recent documents !! FOR TESTING USES ONLY !!
    # directories = @chili_connection.get_resource_tree
# # binding.pry
    # @documents = []
    # cnt = 0
    # directories.each do |dir|
      # break if cnt == 12
      # dir.documents.each do |doc|
        # break if cnt == 12
        # if doc.is_folder == false and !doc.doc_id.blank?
          # @documents += [doc]
          # cnt += 1
        # end
      # end
    # end
  # end


  def home
    @documents = []
    @documents += [{:name => 'Wanted 1', :doc_id => 'f8543b23-7934-43b6-94b6-785aabf29982', :icon_url => 'Training/download.aspx?type=thumb&resourceName=Documents&id=e71dd2c5-9e51-497d-87be-114ea210dbca&apiKey=0FCVP3iGvseH9Ho_iSwYfFtkZHPqRB3y5ZqrbTD_bIfAaa81fRdr4LyCp3AbGPRj3fqr5PlhAvrzaUjiBhyscA==&pageNum=1'}]
  end



  def search
  end

  def editor
## Note: This info should come from the app
user_id, cart_id, workspace_item_id = 23, 1, "1e61933f-b0bf-4f12-be2c-4fb77e60d47e"

    doc = @chili_connection.copy_document_and_return_new_url('test_app', user_id, cart_id, params[:id], params[:doc], workspace_item_id)
    @url, @doc_id = doc[:url], doc[:doc_id]
    ## NOTE: The returned doc_id above is the one to store in cart and if that one is used, we shouldn't be copying anymore

    @chili_connection.set_workspace_admin("false")
    @document_vars = @chili_connection.get_document_values(params[:id])
  end

  def pdf
    xml_settings = '<item name="Default" id="2b71feda-90db-4bc8-a44a-4918cb8aa196" relativePath="" missingAdPlaceHolderColor="#FF00FF" missingAdPlaceHolder="False" missingEditPlaceHolder="False" includeLinks="False" includeGuides="False" includeTextRangeBorder="True" includePageMargins="True" includeFrameBorder="True" imageQuality="original" includeCropMarks="True" includeBleedMarks="True" includeImages="True" includeNonPrintingLayers="False" includeGrid="True" includeBleed="True" includeAdOverlays="False" includeSectionBreaks="False" includePageLabels="False" includeFrameInset="True" includeBaseLineGrid="True" includeSlug="True" includeAnnotations="False" outputSplitPages="1" layoutID="" createAllPages="True" pageRangeStart="1" userPassword="" ownerPassword="" pdfSubject="" pdfKeywords="" watermarkText="" pdfLayers="False" createSingleFile="True" createSpreads="False" serverOutputLocation="" slugLeft="" slugTop="" slugRight="" slugBottom="" bleedRight="3 mm" bleedTop="3 mm" bleedLeft="3 mm" useDocumentBleed="True" useDocumentSlug="True" optimizationOptions="" preflight_overrideDocumentSettings="False" preflight_minOutputResolution="72" preflight_minResizePercentage="70" preflight_maxResizePercentage="120" dataSourceIncludeBackgroundLayers="False" dataSourceCreateBackgroundPDF="True" dataSourceRowsPerPDF="1" dataSourceMaxRows="-1" dontDeleteExistingDirectory="False" collateOutputWidth="210mm" collateNumRows="3" collateNumCols="3" collateOutputHeight="297mm" collateColumnWidth="50mm" collateStartX="10mm" collateStartY="10mm" collateMarginX="10mm" allowExtractContent="True" collateMarginY="10mm" collateOutput="False" collateDrawPageBorder="False" collateIncludeFileHeader="False" missingAdSizePlaceHolderColor="#FF00FF" rgbSwatches="False" dropshadowQuality="150" missingEditPlaceHolderColor="#FF00FF" annotationBorderColor="#FF0000" annotationFillColor="#FFFFFF" annotationOpacity="50" linkBorderColor="#0000FF" dropshadowTextQuality="150" bleedBottom="3 mm" barWidthReduction="0 mm" markOffset="9pt" markWidth="0.5pt" dataSourceEngine="editor_cli" dataSourceNumConcurrent="3" dataSourceUnspecifiedContentType="variable_data" dataSourceIncludeGenerationLog="False" dataSourceUnspecifiedPageContentType="variable_data" outputIntentRegistryName="" outputIntentConditionIdentifier="" outputIntent="" pdfStandard="" pdfVersion="4" debugVtContent="False" watermarkType="" watermarkPdfAssetID="" watermarkPdfAnchor="top_left" pageRangeEnd="999999" watermarkPdfSize="original" convertBlacks="False" convertAnyK100="True" convertSystemBlack="True" convert0_0_0_100="True" convertBlackToC="63" convertBlackToK="100" convertBlackToY="51" convertBlackToM="52" debugDropShadowsWithoutBlur="False" missingAdSizePlaceHolder="False" pdfCreator="CHILI Publisher" pdfAuthor="CHILI Publisher" allowPrinting="True" allowModifyDocument="True" fastWebView="False" embedFonts="True" pdfTitle="" dataSourceCreate="False"><pdfvt_metaDataConfigItems/></item>'
    task_id = @chili_connection.export_pdf(params[:doc_id], xml_settings)
    while task = @chili_connection.task_status(task_id) and task.finished == 'False'; end
    redirect_to ChiliService::PreviewResult.parse(task.result).url
  end

private
  def initialize_chili_vdp
    @chili_connection = Chili::ChiliVdp.new
  end

end
