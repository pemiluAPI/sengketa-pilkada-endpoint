class Dispute < ActiveRecord::Base
  belongs_to :category
  belongs_to :region

  validates :region_id,
   					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }
  scope :by_region_id, lambda{ |region_id| where("region_id = ?", region_id) unless region_id.nil? }
  scope :by_category_id, lambda{ |category_id| where("category_id = ?", category_id) unless category_id.nil? }

  def self.apiall(data = {})
    disputes          = self.by_id(data[:id]).by_region_id(data[:region_id]).by_category_id(data[:category_id])
    paginate_disputes = disputes.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      disputes: paginate_disputes.map{|value| value.construct},
      count: paginate_disputes.count,
      total: disputes.count
		}
  end

  def construct
    return {
      id: id,
      region: handle(region),
      category: handle(category),
      applicant: applicant,
      respondent: respondent,
      disputed: disputed,
      decision_verdict: decision_verdict
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

  def handle(obj)
    obj.present? ? obj.construct : {}
  end

end
