class Dispute < ActiveRecord::Base
  belongs_to :category
  belongs_to :region

  validates :region_id,
   					presence: true

  delegate :constituency, to: :region, prefix: false, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  scope :by_id, lambda{ |id| where("disputes.id = ?", id) unless id.nil? }
  scope :by_region, lambda{ |region_id| where("disputes.region_id = ?", region_id) unless region_id.nil? }
  scope :by_category, lambda{ |category_id| where("disputes.category_id = ?", category_id) unless category_id.nil? }

  def self.apiall(data = {})
    disputes          = self.by_id(data[:id]).by_region(data[:region_id]).by_category(data[:category_id])
    paginate_disputes = disputes.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      disputes: paginate_disputes.map{|dispute|
                  {
                  	id: dispute.id,
                  	region_id: dispute.region_id,
                  	constituency: dispute.constituency,
                  	category_id: dispute.category_id,
                  	category_name: dispute.category_name,
                  	applicant: dispute.applicant,
                  	respondent: dispute.respondent,
                  	disputed: dispute.disputed,
                  	decision_verdict: dispute.decision_verdict
                  }
              	},
      count: paginate_disputes.count,
      total: disputes.count
		}
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end
end
