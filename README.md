
# MovieBox


MovieBox is a web application built using the Ruby on Rails framework, providing users with a platform to explore movie data and ratings from two sources - the TMDB API and the local MovieBox rating system. With the use of Docker for containerization, the application is designed for easy setup and deployment


# Features

- Explore movie data and ratings from the [TMDB API](https://developer.themoviedb.org/reference/movie-details).

- Give ratings to movies and add your comments

- Create and manage local movie objects with custom attributes. 

- Use Docker to run the application in a containerized environment. 

- Authentication through Devise Gem.

- Copy movies from TMDB to MovieBox.

- **Youtube search API** to add trailer url for movies.

# Prerequisites

Before running the application, ensure you have the following installed: 

- Docker([install guide for Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04), [install guide for mac](https://docs.docker.com/desktop/install/mac-install/))

- Docker compose ([install guide for Ubuntu](https://docs.docker.com/desktop/install/mac-install/))


add file with name "development.key" in credential folder

# Installation and Usage 

Clone the repository to your local machine: 
 

    git clone git@github.com:abdullah5514/moviebox.git 
 

Navigate to the "moviebox" directory: 

    cd moviebox

Create a file at `config/credentials` by the name `development.key` and paste the key provided through email.
 
Build the Docker image: 

    docker-compose up --build
 

Access the application: 

    http://0.0.0.0:3000 

To login as an Admin use these credentials:

    email: john@example.com
    password: 12344567

To login as normal User use these credentials:

    email: jane@example.com
    password: 1234567


# Contributing 

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to create an issue or submit a pull request. 

# License 

The MovieBox application is open-source and available under the MIT License. 

# Acknowledgments 

This project was inspired by our love for movies and the desire to learn Ruby on Rails. 
 

# Contact 

If you have any questions or need further assistance, you can contact us at mabdullah3833@gmail.com