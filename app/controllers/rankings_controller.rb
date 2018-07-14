class RankingsController < ApplicationController
  def want
    @ranking_counts = Want.ranking
    #→ [3=>10, 5=>6, 2=>5, 8=>3, ...] のように [item_id => Want の数] というハッシュデータが入っています
    #このデータだけではitemsを表示できないので、
    @items = Item.find(@ranking_counts.keys)
                      #→ハッシュからitem_idだけ取り出した配列を取得
            #→itemsを取得
    #→ランキングの順番通りのまま
  end
end
