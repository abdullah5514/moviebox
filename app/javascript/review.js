// document.addEventListener("turbo:load", function () {
//   // Add event listeners to stars for hover and click events
//   const stars = document.querySelectorAll(".star-rating .star");

//   stars.forEach((star) => {
//     star.addEventListener("mouseover", function () {
//       const rating = parseInt(star.dataset.value);
//       highlightStars(rating);
//     });

//     star.addEventListener("mouseout", function () {
//       const currentRating = parseInt(this.parentNode.querySelector(".star.checked").dataset.value);
//       highlightStars(currentRating);
//     });

//     star.addEventListener("click", function () {
//       const rating = parseInt(star.dataset.value);
//       selectStar(rating);

//       // Update the hidden input field with the selected rating value
//       const input = this.parentNode.querySelector(".star-input");
//       input.value = rating;
//     });
//   });

//   // Function to highlight stars on hover
//   function highlightStars(rating) {
//     const stars = document.querySelectorAll(".star-rating .star");
//     stars.forEach((star) => {
//       const starValue = parseInt(star.dataset.value);
//       if (starValue <= rating) {
//         star.classList.add("highlighted");
//       } else {
//         star.classList.remove("highlighted");
//       }
//     });
//   }

//   // Function to select a star (for click event)
//   function selectStar(rating) {
//     const stars = document.querySelectorAll(".star-rating .star");
//     stars.forEach((star) => {
//       const starValue = parseInt(star.dataset.value);
//       if (starValue <= rating) {
//         star.classList.add("hover");
//       } else {
//         star.classList.remove("hover");
//       }
//     });
//   }
// });