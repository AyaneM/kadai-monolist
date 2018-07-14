class Want < Ownership
  #クラスメソッド作成。Want.rankingのようにクラス自体から呼び出せる。
  def self.ranking
    self.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)
    #SQLのGROUP BYにより、item_idカラムが同一のものをグループに。
    #count(:item_id)でグループ化したそれぞれのitem_idを数える。
  end
end