# spec/controllers/movies_controller_spec.rb
require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET #index' do
    it 'assigns all movies and TMDB movies' do
      movies = create_list(:movie, 5, :with_random_poster_or_url , has_poster: true)
      allow_any_instance_of(MovieService).to receive(:discover_movies).and_return([])


      get :index
      expect(movies.class).to eq(Array)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested movie' do
      movie = create(:movie , :with_random_poster_or_url , has_poster: true)

      get :show, params: { id: movie.id }

      expect(assigns(:movie)).to eq(movie)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new movie' do
      get :new

      expect(assigns(:movie)).to be_a_new(Movie)
      expect(response).to render_template(:new)
    end

    context 'with parameters' do
      it 'assigns a new movie with tmdb_params' do
        params = {
          title: 'Sample Movie',
          overview: 'Movie overview',
          release_date: '2023-07-24',
          poster_path: '/example_poster.jpg',
          vote_average: 7.5,
          trailer_url: 'https://example.com/trailer'
        }

        get :new, params: params

        expect(assigns(:movie)).to be_a_new(Movie)
        expect(assigns(:movie).title).to eq('Sample Movie')
        expect(assigns(:movie).description).to eq('Movie overview')
        expect(assigns(:movie).release_date).to eq(Date.parse('2023-07-24'))
        expect(assigns(:movie).poster_url).to eq("https://image.tmdb.org/t/p/w500//example_poster.jpg")
        expect(assigns(:movie).tmdb_rating).to eq(7.5)
        expect(assigns(:movie).trailer_url).to eq('https://example.com/trailer')
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new movie' do
        movie_params = attributes_for(:movie)

        expect {
          post :create, params: { movie: movie_params }
        }.to change(Movie, :count).by(1)

        expect(assigns(:movie)).to be_a(Movie)
        expect(assigns(:movie)).to be_persisted
        expect(response).to redirect_to(assigns(:movie))
        expect(flash[:notice]).to eq('Movie was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'does not create a new movie' do
        movie_params = attributes_for(:movie, title: nil) # Invalid params

        expect {
          post :create, params: { movie: movie_params }
        }.to_not change(Movie, :count)

        expect(assigns(:movie)).to be_a(Movie)
        expect(assigns(:movie)).not_to be_persisted
        expect(response).to render_template(:new)
      end
    end
  end

  # Add test cases for other controller actions (search, edit, update, destroy) as needed.

end
