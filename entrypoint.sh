#!/bin/bash

# Function to check if the database is ready
wait_for_db() {
  while ! nc -z db 5432; do
    echo "Waiting for the database container to be up..."
    sleep 2
  done
}

# Call the wait_for_db function
wait_for_db

# Run the Rails database setup tasks
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed

# Execute the command passed as arguments
exec "$@"