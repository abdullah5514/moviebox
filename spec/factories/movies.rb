FactoryBot.define do
    factory :movie do
      title { Faker::Lorem.unique.word }
      release_date { Faker::Date.between(from: 10.years.ago, to: Date.today) }
        # Define a trait to generate a random poster URL
      trait :with_random_poster_url do
        poster_url { Faker::Internet.url }
      end
  
      # Define a trait to generate a random poster file
      trait :with_random_poster do
        poster { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'image.jpeg'), 'image/jpeg')}
        poster_url { nil }
      end


  
      # Define a trait to set 23 poster or poster_url randomly
      trait :with_random_poster_or_url do
        transient do
          has_poster { [true, false].sample }
        end
        
  
        poster { has_poster ? Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'image.jpeg'), 'image/jpeg') : nil }
        poster_url { has_poster ? nil : 'https://images.pexels.com/photos/2873486/pexels-photo-2873486.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1' }
      end
    end
  end
  