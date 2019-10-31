class EmailSelect {
  constructor($selectContainer) {
    $selectContainer.select2({
      placeholder: Spree.translations.choose_an_email,
      minimumInputLength: 3,
      ajax: {
        url: Spree.pathFor('api/users/emails'),
        params: { 'headers': { 'Authorization': `Bearer ${Spree.api_key}`, 'X-Spree-Token': Spree.api_key } },
        datatype: 'json',
        data: (term, data) => (
          {
            q: {
              email_start: term
            }
          }
        ),
        results: (data, page) => (
          {
            results: data.users.map((user) => (
              {...user, id: user.email}
            )),
            more: data.more
          }
        )
      },
      formatResult: (user) => (
        `<div class='user-email-autocomplete-item'>` +
          `<div class='user-email-details'>` +
            `<span class='user-email'>${user.email}</span><br />` +
            `<span class='user-orders-count'>` +
              `<small>${Spree.t('admin.gdpr.orders_count')}: ${user.orders_count}</small>` +
            `</span>` +
          `</div>` +
        `</div>`
      ),
      formatSelection: (user) => (user.email)
    })
  }
}

Spree.ready(() => {
  $selectContainer = $('.js-gdpr-request-email')

  if ($selectContainer.is('*')) {
    new EmailSelect($selectContainer)
  }
})
