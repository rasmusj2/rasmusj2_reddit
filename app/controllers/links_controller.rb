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

  def vote
    @link = Link.find(params[:id])
    if @link.user == current_user
      redirect_to links_url, :alert => 'Voting Not Allowed On Your Links' and return
    end

    @vote = Vote.find_or_initialize_by_link_id_and_voter_id(@link.id, current_user.id)
    case params[:type]
    when 'up'
      @vote.score = 1
    when 'down'
      @vote.score = -1
    else
      render :nothing => true, :status => 400 and return
    end

    respond_to do |format|
      if @vote.save
        format.html { redirect_to links_url, :notice => 'Vote Recorded' }
      else
        format.html { redirect_to links_url, :alert => 'Error Recording Vote' }
      end
    end
  end
end
