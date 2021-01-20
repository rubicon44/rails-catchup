var RailsCatchup = RailsCatchup || {};

// show
$(document).on('turbolinks:load', function () {
  // タブ切り替え
  RailsCatchup.tabControl = function() {
    switchTab({
      $tabs: $('.js-tab').children(),
      $contents: $('.js-tabContents').children()
    });
  };

  function switchTab(param) {
    param.$tabs.on('click', function() {
      var index = param.$tabs.index(this);

      param.$contents.removeClass('active');
      param.$contents.eq(index).addClass('active');

      param.$tabs.removeClass('active');
      param.$tabs.eq(index).addClass('active');
    });
  }

  RailsCatchup.tabControl();
});