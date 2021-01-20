// // static_pages
// var RailsCatchup = RailsCatchup || {};

// // home
// $(document).on('turbolinks:load', function () {
//   // ゲストログインModal
//   RailsCatchup.modalControl = function() {
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

//   RailsCatchup.modalControl();
// });