class Region < ActiveRecord::Base
  has_many :disputes

  validates :constituency,
   					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }

  def self.apiall(data = {})
    regions          = self.by_id(data[:id])
    paginate_regions = regions.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      regions: paginate_regions.map{|value| value.construct},
      count: paginate_regions.count,
      total: regions.count
		}
  end

  def construct
    return {
      id: id,
      constituency: constituency
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
