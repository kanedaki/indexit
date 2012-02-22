class EntriesController < ApplicationController
  respond_to :json

  def index
    if params[:search_term].present?
      puts "Searching......"
      #Do the heavy stuff. Elastic search, mongodb....
      entries = Entry.all
    else
      entries = Entry.all
    end
    respond_with entries
  end

  def show
    respond_with Entry.find(params[:id])
  end

  def create
    respond_with Entry.create(params[:entry])
  end

  def update
    respond_with Entry.update(params[:id], params[:entry])
  end
 
  def destroy
    respond_with Entry.destroy(params[:id])
  end

end
