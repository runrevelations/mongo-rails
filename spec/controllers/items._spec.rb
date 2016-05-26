require "rails_helper"

RSpec.describe Api::V1::ItemsController, :type => :controller do

  describe 'get #index' do
    it 'gets all items' do

      items = Item.create([{ name: 'Cool Whip', price: 4.35 }, { name: 'Cheese Wiz', price: 3.75 }])

      get :index
      response_body = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response_body[0]['name']).to eq('Cool Whip')
      expect(response_body[0]['price']).to eq(4.35)
      expect(response_body[1]['name']).to eq('Cheese Wiz')
      expect(response_body[1]['price']).to eq(3.75)
    end
  end

  describe 'get #show' do
  	it 'gets one item by :id' do
        
        item = Item.new(name: 'Dell XPS13 9343', price: 20.20)
        item.save

  		get :show, id: item.id
  		response_body = JSON.parse(response.body)

  		expect(response).to be_success
  		expect(response).to have_http_status(200)
  		expect(response_body['name']).to eq("Dell XPS13 9343")
  		expect(response_body['price']).to eq(20.20)
  	end
  end

  describe 'post #create' do 
  	it 'creates a new item' do

  		post :create, :item => {name: 'Screwdriver', price: 5.75}
        
        response_body = JSON.parse(response.body)

  		expect(response).to be_success
  		expect(response).to have_http_status(201)
  		expect(response_body['name']).to eq('Screwdriver')
  		expect(response_body['price']).to eq(5.75)

    end
  end

  describe 'post #create ERROR' do
  	it 'tries to create an item' do 

  		post :create, :item => {phone: 'Iphone6', numbers: 650.55, description: 'Huge Screen'}
        
        response_body = JSON.parse(response.body)
        
        expect(response).to have_http_status(422)
        expect(response_body['name']).to eq(['can\'t be blank'])
        expect(response_body['price']).to eq(['can\'t be blank'])

  	end
  end

  describe 'put #update' do
  	it 'updates one item' do

  		item = Item.new(name: 'Bucket', price: 5.35)
  		item.save

  		put :update, id: item.id, :item => {name: 'Shoe', price: 12.00}
        
        response_body = JSON.parse(response.body)
        
        expect(response).to have_http_status(200)
        expect(response_body['price']).to eq(12.00)
  		expect(response_body['name']).to eq('Shoe')

  	end
  end

  describe 'delete #destroy' do
  	it 'deletes one item' do

  		item = Item.new(name: 'Coaster', price: 2.50)
  		item.save

  		delete :destroy, id: item.id
        
        response_body = JSON.parse(response.body)

        expect(response).to have_http_status(200)
  		expect(response_body['message']).to eq('Item was successfully deleted.')
  	end
  end


end