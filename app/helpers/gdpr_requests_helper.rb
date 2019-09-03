# frozen_string_literal: true

module GdprRequestsHelper
  def title_case(text)
    return '' unless text

    text.split('_').map(&:capitalize).join(' ')
  end
end
