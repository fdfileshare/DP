class Dp::NewsCommentsController < ApplicationController


  # POST /news_comment
  # POST /news_comment.json
  def create
    @news_comment = NewsComment.new(news_comment_params)

    respond_to do |format|
      if @news_comment.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end
end
