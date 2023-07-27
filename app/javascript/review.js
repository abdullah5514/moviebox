const stars = document.querySelectorAll(".star");
stars.forEach((star, index) => {
  star.addEventListener("click", function () {
    const selectedRating = index + 1; // Add 1 to the index to get the selected rating
    stars.forEach((star, i) => {
      if (i < selectedRating) {
        star.classList.add("selected");
      } else {
        star.classList.remove("selected");
      }
    });

    // Send the selectedRating value to the server or perform any action you need
    console.log("Selected rating:", selectedRating);
  });
});

 document.addEventListener('DOMContentLoaded', function() {
  var flashMessage = document.getElementById('flash-message');
  if (flashMessage) {
    setTimeout(function() {
      flashMessage.style.display = 'none';
    }, 3000);
  }
});
