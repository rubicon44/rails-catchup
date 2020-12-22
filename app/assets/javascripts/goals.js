// comment
var Grow = Grow || {};

// show
$(document).on('turbolinks:load', function () {
  // コメントModal
  Grow.modalControl = function() {
    switchModal({
      $modal: $('.js-modal'),
      $modalOn: $('.js-modalOn'),
      $modalBg: $('.js-modalBg')
    });
  };

  function switchModal(param) {
    param.$modalOn.on('click', function() {
      param.$modalBg.fadeIn();
      param.$modalBg.css('pointer-events','none');
      param.$modal.fadeIn();
    });
  }

  Grow.modalControl();
});