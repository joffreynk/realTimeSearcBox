require 'rails_helper'
require 'socket'

RSpec.describe "Queries", type: :request do
  before(:all) do
    @address = Socket.ip_address_list[1].ip_address
  end

  context "User queries" do


    def createSearch(query)
      address = @address
      
      if Query.where(userip: address).empty?
        Query.create(query:, userip: address, times: 1)
      else
        lastquery = Query.where(userip: address).order('updated_at DESC').first.query
        if query.start_with?(lastquery)
          if lastquery.length < query.length
            Query.find_by(query: lastquery, userip: address).update(query:)
          end
        else
          attempt = Query.find_by(query:, userip: address)
          if !attempt.nil? && attempt.query.to_s == query
            attempt.update(times: attempt.times.to_i + 1)
          else
            Query.create(query:, userip: address, times: 1)
          end
        end
      end
    end

    it 'User can only see his queries' do
      search = "what is a good car"
      get "/queries"
      
      createSearch("hello world")
      createSearch(search)
      createSearch("hello world")
      createSearch(search)
      createSearch("hello world")
      createSearch(search)
      createSearch("hello world")
      createSearch(search)

      expect(Query.where(userip: @address).count).to eql(2)
    end

    it 'get null if the user have different ip' do
        search = "what is a good car"
        get "/queries"
        
        createSearch("hello world")
        createSearch(search)
        createSearch("hello world")
        createSearch(search)
        createSearch("hello world")
        createSearch(search)
        createSearch("hello world")
        createSearch(search)
  
        expect(Query.where(userip: '192.168.20.3').count).to eql(0)
      end


  end

end