document.addEventListener("DOMContentLoaded", () => {
    const toggleButton = document.getElementById("add-video-link-btn");
    toggleButton.style.display = "none";
   const movieTitle = document.getElementById("movie_title").value.trim();
   
   // If the movie title exists, call the search function with the title
   if (movieTitle) {
     searchYouTubeTrailers(movieTitle);
   }
  
   const youtubeSearchBtn = document.getElementById("youtube-search-btn");
   youtubeSearchBtn.addEventListener("click", () => {
     const query = document.getElementById("youtube-search-query").value.trim();
     if (query) {
       searchYouTubeTrailers(query);
     }
   });
  
   function searchYouTubeTrailers(query) {
     // Make an AJAX request to the /search endpoint with the provided query
     const url = `/search?query=${encodeURIComponent(query)}`;
  
     fetch(url)
       .then((response) => response.json())
       .then((data) => displayYouTubeTrailers(data))
       .catch((error) => console.error("Error fetching trailers:", error));
   }
  
   function displayYouTubeTrailers(items) {
     const youtubeTrailerResults = document.querySelector(".youtube-trailer-results");
     youtubeTrailerResults.innerHTML = "";
  
     items.related_movies.forEach((item) => {
       const videoId = item.video_id.video_id;
       const videoTitle = item.description;
       const videoThumbnail = item.thumbnail_url;
  
       const trailerItem = `
         <div class="youtube-trailer-item">
           <div class="video-placeholder">
             <img src="${videoThumbnail}" alt="${videoTitle}" class="img-fluid" data-video-id="${videoId}" data-video-title="${videoTitle}">
              <div class="play-button-container">
               <svg class="play-button-svg" viewBox="0 0 64 64">
                 <polygon points="22,17 22,47 48,32"></polygon>
               </svg>
             </div>
           </div>
         </div>
       `;
       youtubeTrailerResults.insertAdjacentHTML("beforeend", trailerItem);
     });
  
     // Add click event listener to the video thumbnails
     const thumbnailItems = document.querySelectorAll(".video-placeholder");
     thumbnailItems.forEach((container) => {
       container.addEventListener("click", () => {
         const videoId = container.querySelector("img").getAttribute("data-video-id");
         const videoTitle = container.querySelector("img").getAttribute("data-video-title");
         playVideoInEmbeddedPlayer(videoId, videoTitle);
         toggleButton.style.display = "block";
       });
     });
   }
  
   function playVideoInEmbeddedPlayer(videoId, videoTitle) {
     const youtubePlayer = document.getElementById("youtube-player");
     youtubePlayer.innerHTML = `
       <iframe
         width="560"
         height="315"
         src="https://www.youtube.com/embed/${videoId}?autoplay=1"
         title="${videoTitle}"
         frameborder="0"
         allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
         allowfullscreen
       ></iframe>
     `;
   }
  
   const addVideoLinkBtn = document.getElementById("add-video-link-btn");
   addVideoLinkBtn.addEventListener("click", addVideoLinkToForm);
  
   function addVideoLinkToForm(event) {
     event.preventDefault(); // Prevent form submission
  
     const youtubePlayer = document.getElementById("youtube-player");
     const trailerUrlField = document.getElementById("movie_trailer_url"); // Replace "movie" with the actual form model
  
     // Get the video ID from the YouTube player URL
     const youtubeVideoId = extractYouTubeVideoId(youtubePlayer.innerHTML);
  
     if (youtubeVideoId) {
       // Construct the full YouTube video URL
       const youtubeVideoUrl = `https://www.youtube.com/embed/${youtubeVideoId}?autoplay=1`;
  
       // Update the trailer_url field with the YouTube video URL
       trailerUrlField.value = youtubeVideoUrl;
     } else {
       console.error("Error extracting YouTube video ID.");
     }
   }
  
   // Function to extract the YouTube video ID from the player HTML
   function extractYouTubeVideoId(playerHtml) {
     const regex = /youtube\.com\/embed\/([^?"]+)/;
     const match = playerHtml.match(regex);
     return match ? match[1] : null;
   }
  
  });