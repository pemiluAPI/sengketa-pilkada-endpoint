module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :regions do
      desc "Return list regions"
      get do
        results = Region.apiall(params)
        {
          results: results
        }
      end
    end

    resource :categories do
      desc "Return list categories"
      get do
        results = Category.apiall(params)
        {
          results: results
        }
      end
    end

    resource :disputes do
      desc "Return list disputes"
      get do
        results = Dispute.apiall(params)
        {
          results: results
        }
      end
    end
  end
end