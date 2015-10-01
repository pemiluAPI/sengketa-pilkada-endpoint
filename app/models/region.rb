class Region < ActiveRecord::Base
  has_many :disputes

  validates :constituency,
   					presence: true

  def self.apiall(data = {})
    regions          = self.all
    paginate_regions = regions.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      regions: 	paginate_regions.map{|region|
                  {
                  	id: region.id,
                  	constituency: region.constituency
                  }
              	},
      count: paginate_regions.count,
      total: regions.count
		}
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
