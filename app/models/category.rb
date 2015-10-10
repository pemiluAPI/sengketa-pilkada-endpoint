class Category < ActiveRecord::Base
  has_many :disputes

  validates :name,
   					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }

  def self.apiall(data = {})
    categories          = self.by_id(data[:id])
    paginate_categories = categories.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      categories: paginate_categories.map{|value| value.construct},
      count: paginate_categories.count,
      total: categories.count
		}
  end

  def construct
    return {
      id: id,
      name: name
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
