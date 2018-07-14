class ItemsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @items = []
  
    @keyword = params[:keyword]
    if @keyword
      results = RakutenWebService::Ichiba::Item.serch({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })
      
      results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item
        #itemを[]に追加していく
      end
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
    @have_users = @item.have_users
  end
 
end