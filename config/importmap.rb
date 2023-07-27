# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "review", to: 'review.js'
pin "youtube", to: 'youtube.js'

pin "popper", to: 'popper.js', preload: true

pin "bootstrap", to: 'bootstrap.min.js', preload: true
