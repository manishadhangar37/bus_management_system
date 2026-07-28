// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

import * as bootstrap from "bootstrap"

// window.bootstrap = bootstrap
// document.addEventListener("turbo:load", () => {
//   const carousel = document.querySelector("#busCarousel");

//   if (carousel) {
//     new bootstrap.Carousel(carousel, {
//       interval: 2000,
//       ride: "carousel"
//     });
//   }
// });