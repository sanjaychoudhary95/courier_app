class SearchController < ApplicationController
  def index
    # Using the id as the unique number might expose internal implementation details and can be easily guessable by users, which may lead to potential security issues.
    if params[:search].present?
      @parcels = Parcel.where(tracking_number: params[:search])
    else
      @parcels = []
    end
  end
end
