class LinksController < ApplicationController
before_filter :authenticate_user!, :except => :index

  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    @link.user = current_user

    respond_to do |format|
      if @link.save!
        format.html { redirect_to(links_path, :notice => 'Link was successfully added.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
