# frozen_string_literal: true

module Spree
  class Email
    PER_PAGE = 10

    class << self
      def where(keyword = '')
        user_scope = user_scope(keyword)
        order_scope = order_scope(keyword)

        new(
          execute(limit_sql(user_scope, order_scope)),
          execute(count_sql(user_scope, order_scope)).first.count
        )
      end

      private

      def user_scope(keyword)
        ::Spree::User.ransack(keyword).result.select(:email)
      end

      def order_scope(keyword)
        ::Spree::Order.ransack(keyword).result.select(:email)
      end

      def limit_sql(user_scope, order_scope)
        <<~SQL
          SELECT email
          FROM (#{user_scope.to_sql} UNION #{order_scope.to_sql})
          limit #{PER_PAGE}
        SQL
      end

      def count_sql(user_scope, order_scope)
        <<~SQL
          SELECT COUNT(*) as count
          FROM (#{user_scope.to_sql} UNION #{order_scope.to_sql}) emails
        SQL
      end

      def execute(sql)
        ActiveRecord::Base.connection.execute(sql)
      end
    end

    def initialize(users, count)
      @users = users
      @count = count
    end

    def items
      @users.map do |user|
        {
          email: user['email'],
          orders_count: orders_count[user['email']]
        }
      end
    end

    def more?
      (@count.to_f / PER_PAGE).ceil > 1
    end

    private

    def orders_count
      emails = @users.map { |user| user['email'] }
      @orders_count ||= ::Spree::Order.where(email: emails).group(:email).count
    end
  end
end
