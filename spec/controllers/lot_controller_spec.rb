require 'rails_helper'

RSpec.describe LotsController, type: :controller do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @lots' do
      lot1 = Lot.create(name: 'Lot 1', description: 'Description 1')
      lot2 = Lot.create(name: 'Lot 2', description: 'Description 2')

      get :index
      expect(assigns(:lots)).to contain_exactly(lot1, lot2)
    end
  end

  describe 'GET #show' do
    let(:lot) { Lot.create(name: 'Lot', description: 'Description') }

    it 'renders the show template' do
      get :show, params: { id: lot.id }
      expect(response).to render_template(:show)
    end

    it 'assigns @lot' do
      get :show, params: { id: lot.id }
      expect(assigns(:lot)).to eq(lot)
    end

    it 'assigns @bid' do
      bid = lot.bids.create(amount: 10)

      get :show, params: { id: lot.id }
      expect(assigns(:bid)).to eq([bid])
    end

    it 'assigns @leading_bid' do
      bid1 = lot.bids.create(amount: 10)
      bid2 = lot.bids.create(amount: 20)

      get :show, params: { id: lot.id }
      expect(assigns(:leading_bid)).to eq(bid2)
    end
  end

  describe 'GET #new' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns a new lot' do
        get :new
        expect(assigns(:lot)).to be_a_new(Lot)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  # Test other actions in a similar way...

  describe 'POST #create' do
    let(:valid_params) do
      {
        lot: {
          name: 'New Lot',
          description: 'Description',
          user_id: user.id
        }
      }
    end

    context 'when user is authenticated' do
      before { sign_in user }

      it 'creates a new lot' do
        expect {
          post :create, params: valid_params
        }.to change(Lot, :count).by(1)
      end

      it 'redirects to the created lot' do
        post :create, params: valid_params
        expect(response).to redirect_to(lot_path(Lot.last))
      end

      it 'sets a flash notice' do
        post :create, params: valid_params
        expect(flash[:notice]).to eq('Lot was successfully created.')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        post :create, params: valid_params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  # Test other actions in a similar way...
end
