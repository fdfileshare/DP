class Dp::NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  # GET /news.json
  def index
    @news = News.where("post_at < '" + Time.now.strftime('%Y/%m/%d') +"'" ).order('post_at DESC')
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])
    if request.post? then
        @comment = NewsComment.new(news_comment_params)
    end
    @new_comment = NewsComment.new
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to dp_news_index_url, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to dp_news_index_url, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to dp_news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # POST /news
  # POST /news.json
  def createComment

    if request.post? then
      @comment = NewsComment.new(news_comment_params)
      respond_to do |format|
        if @comment.save
          format.html { redirect_to dp_news_path(@comment.news), notice: 'News was successfully created.' }
          format.json { render :show, status: :created, location: @news }
        else
          format.html { render :new }
          format.json { render json: @news.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def search
    @search_key = params[:search]
    @news = News.search(@search_key)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.fetch(:news, {}).permit(:title, :description, :eyecatch, :post_at)
    end
    def news_comment_params
      params.fetch(:news_comment, {}).permit(:news_id, :name, :email, :description)
    end

end
