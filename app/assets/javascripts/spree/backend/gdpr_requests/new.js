Spree.ready(function() {
  if ($(".js-gdpr-request-user").length) {
    new Spree.Views.Order.CustomerSelect({
      el: $('#gdpr_request_user_id')
    });
  }
});
