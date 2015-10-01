class Category < ActiveRecord::Base
  has_many :disputes

  validates :name,
   					presence: true

  def self.apiall(data = {})
    categories          = self.all
    paginate_categories = categories.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      categories: paginate_categories.map{|category|
                  {
                  	id: category.id,
                  	name: category.name
                  }
              	},
      count: paginate_categories.count,
      total: categories.count
		}
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
