require_relative '../spec_helper.rb'

describe API, type: :api do
  include Rack::Test::Methods

  def app
    API
  end

  before do
    @shops = []
    2.times { @shops << create(:shop) }
    @publisher = create :publisher
    @publisher.books.each do |book|
      @shops.each do |shop|
        create :stock, shop: shop, book: book
      end
    end
  end

  context 'GET /api/v1/stock/for_publisher/:publisher_id' do
    context 'if publisher present' do
      before do
        get "/v1/stock/for_publisher/#{@publisher.id}"
      end

      it 'returns http success' do
        expect(last_response.status).to eq(200)
      end

      it 'should returns an array of shops' do
        expect(last_response.body).to look_like_json
        expect(body_as_json).to have_key(:shops)
      end
    end

    context 'if publisher not found' do
      before do
        get '/v1/stock/for_publisher/1000'
      end

      it 'returns http not_found' do
        expect(last_response.status).to eq(404)
      end
    end
  end

  context 'POST /api/v1/stock/sold' do
    context 'if stock present' do
      before do
        @shop = @shops.sample
        @book = @shop.books.sample
        stock = @shop.stocks.find_by book: @book
        @stock_count_was = stock.stock_count
        @sold_count_was = stock.sold_count
        @amount = 2
        params = { shop_id: @shop.id, book_id: @book.id, amount: @amount }
        post '/v1/stock/sold', params
      end

      it 'returns http created' do
        expect(last_response.status).to eq(201)
      end

      it 'stock params should changes correctly' do
        expect(last_response.body).to look_like_json
        expect(body_as_json[:shop_id]).to eq(@shop.id)
        expect(body_as_json[:book_id]).to eq(@book.id)
        expect(body_as_json[:stock_count]).to eq(@stock_count_was - @amount)
        expect(body_as_json[:sold_count]).to eq(@sold_count_was + @amount)
      end
    end

    context 'if stock not found' do
      before do
        params = { shop_id: 1000, book_id: 1000 }
        post '/v1/stock/sold', params
      end

      it 'returns http not_found' do
        expect(last_response.status).to eq(404)
      end
    end
  end
end
