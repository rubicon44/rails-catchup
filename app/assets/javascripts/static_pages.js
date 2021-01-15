// // static_pages
// var Grow = Grow || {};

// // home
// $(document).on('turbolinks:load', function () {
//   // ゲストログインModal
//   Grow.modalControl = function() {
//     switchModal({
//       $container: $('.js-container'),
//       $modal: $('.js-modal'),
//       $modalBg: $('.js-modalBg'),
//       $modalOn: $('.js-modalOn'),
//       $modalOff: $('.js-modalOff')
//     });
//   };

//   function switchModal(param) {
//     param.$modalOn.on('click', function() {
//       param.$modalBg.fadeIn();
//       param.$container.css('pointer-events','none');
//       param.$modal.fadeIn();
//       param.$modal.css('pointer-events','auto');
//     });

//     param.$modalOff.on('click', function() {
//       param.$modalBg.fadeOut();
//       param.$modal.fadeOut();
//       param.$container.css('pointer-events','auto');
//     });
//   }

//   Grow.modalControl();
// });