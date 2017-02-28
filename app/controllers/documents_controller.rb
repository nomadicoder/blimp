require 'tempfile'
require 'harvest_csv'

class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
    basename = Dir::Tmpname.make_tmpname(['solr_map-', '.yml'], nil)
    @document.map_filename = File.join(Rails.root, 'tmp', basename)
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    # Generate a SOLR map file
    HarvestCSV.make_map(@document.datafile.current_path,
                        @document.map_filename,
                        @document.id_field)

    respond_to do |format|
      if @document.save
        # Harvest the data
        HarvestCSV.harvest(@document.datafile.current_path,
                           @document.map_filename,
                           solr_endpoint = 'http://localhost:8983/solr/blacklight-core')
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        HarvestCSV.harvest(@document.datafile.current_path,
                           @document.map_filename,
                           solr_endpoint = 'http://localhost:8983/solr/blacklight-core')
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    FileUtils.rm(@document.datafile.current_path) if FileTest.exist?(@document.datafile.current_path)
    FileUtils.rm(@document.map_filename) if FileTest.exist?(@document.map_filename)
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:map_filename, :id_field, :datafile, :datafile_cache)
    end
end
