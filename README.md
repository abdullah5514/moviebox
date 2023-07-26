MovieBox 

MovieBox is a web application built using the Ruby on Rails framework, providing users with a platform to explore movie data from two sources - the TMDB API and the local MovieBox rating system. With the use of Docker for containerization, the application is designed for easy setup and deployment
Features 

Explore movie data from the TMDB API.  link = https://developer.themoviedb.org/reference/movie-details

Create and manage local movie objects with custom attributes. 

Use Docker to run the application in a containerized environment. 

Prerequisites      

Before running the application, ensure you have the following installed: 

Docker: Official Website or you can use =  https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04

add file with name "development.key" in credential folder

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

Open your web browser and go to  http://0.0.0.0:3000 

Configuration 

The application uses PostgreSQL as the database. Make sure to set the appropriate environment variables in the .env file for the database credentials. 

Contributing 

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to create an issue or submit a pull request. 

License 

The MovieBox application is open-source and available under the MIT License. 

Acknowledgments 

This project was inspired by our love for movies and the desire to learn Ruby on Rails. 
 

Contact 

If you have any questions or need further assistance, you can contact us at mabdullah5514@yahoo.com. 