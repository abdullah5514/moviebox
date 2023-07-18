MovieBox 

MovieBox is a Rails application that allows users to explore movie data from the IMDb API and create local movie objects. It utilizes Docker for containerization, making it easy to set up and deploy. 

Features 

Explore movie data from the IMDb API. 

Create and manage local movie objects with custom attributes. 

Use Docker to run the application in a containerized environment. 

Prerequisites 

Before running the application, ensure you have the following installed: 

Docker: Official Website 

Installation and Usage 

Clone the repository to your local machine: 

bashCopy code 

git clone git@github.com:abdullah5514/moviebox.git 
 

Navigate to the "moviebox" directory: 

bashCopy code 

cd moviebox 
 

Build the Docker image: 

docker-compose up -d && docker-compose run rails rails db:create && docker-compose run rails rails db:migrate && docker-compose run rails rails db:seed
 

Access the application: 

Open your web browser and go to http://localhost:3000. 

Configuration 

The application uses PostgreSQL as the database. Make sure to set the appropriate environment variables in the .env file for the database credentials. 

Contributing 

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to create an issue or submit a pull request. 

License 

The MovieBox application is open-source and available under the MIT License. 

Acknowledgments 

This project was inspired by our love for movies and the desire to learn Ruby on Rails. 

Special thanks to OpenAI for providing valuable knowledge resources. 

Contact 

If you have any questions or need further assistance, you can contact us at mabdullah5514@yahoo.com. 