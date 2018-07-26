class OwnershipsController < ApplicationController
  
  #ボタン押された
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    unless @item.persisted?
    # @item が保存されていない場合、先に @item を保存する
      results = RakutenWebService::Ichiba::item.search(itemCode: @item.code)
      @item = Item.new(read(results.first))
      @item.save
    end
    
    if params[:type] == 'Want'
      current_user.want(@item)
      #sessions_helperで定義したcurrent_user
      flash[:success] = "商品をWantしました。"
    elsif params[:type] == 'Have'
      #migrationファイルで書いたtype
      current_user.have(@item)
      flash[:success] = "商品をHaveしました。"
    end
    redirect_back(fallback_location: root_path)
  end
    

  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = '商品のWantを解除しました。'
    elsif params[:type] == 'Have'
      current_user.unhave(@item)
      flash[:success] = '商品のHaveを解除しました。'
    end
    redirect_back(fallback_location: root_path)
  end
  
end
