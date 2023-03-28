require 'rails_helper'
require 'socket'

RSpec.describe "Articles", type: :request do
  before(:all) do
    Article.create(title: 'What is a good car?')
    Article.create(title: 'How is emil hajric doing?')
    Article.create(title: 'Hello world how are you?')
    Article.create(title: 'Manuscript Organization Language')
    Article.create(title: 'Reference Style and Format')
    Article.create(title: 'Citation with one author')
  end
  
  context "GET /index: test searching functionality and analitics" do

    it 'return all items if no parameter is passed' do
      get "/"
      expect(Article.all.length).to eq(6)
    end

    it 'register searched key' do
      search = "hello world"
      get "/", params: search
      expect(Article.where('LOWER(title) like  ?', "%#{search.downcase.strip}%").length).to eq(1)
    end

    it 'cannot have comments' do
      search = "hello world"
      get "/", params: search
      expect(Article.where('LOWER(title) like  ?', "%#{search.downcase.strip}%")[0].title).to eq('Hello world how are you?')
    end

  end


  context "GET /index: test searching functionality" do


    def createSearch(query)
      address = Socket.ip_address_list[1].ip_address
      
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


    it 'at the first time it receives search key and save it' do
      search = "hello"
      get "/", params: search
      expect(createSearch(search).query).to eq(search)
    end

    it 'when it receives a longer query that starts with same key as the previous one it update the previous and still have one query' do
      search = "hello world"

      get "/", params: search

      createSearch('hello')
      createSearch(search)
      expect(Query.all[0].query == search && Query.all.length == 1).to be(true)
    end

    it 'if the previous query is not equal as the previous query it adds it' do
      search = "what is a good car"
      get "/", params: search
      createSearch("hello world")
      createSearch(search)
      expect(Query.all.length).to eq(2)
    end

    it 'if we use the same key search in different times, it is going to increament counts' do
      search = "what is a good car"
      get "/", params: search
      
      createSearch("hello world")
      createSearch(search)
      createSearch("hello world")
      createSearch(search)

      expect(Query.where(query: search)[0].times == 2 && Query.where(query: "hello world")[0].times==2).to be(true)
    end


  end

end
