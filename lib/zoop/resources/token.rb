module Zoop
  class Token < Zoop::Model

    def create
      url = self.class.url(self.card_number)
      update Zoop::Request.post(url, params: to_hash).run
      self
    end

    class << self

      def url(card_number = nil)
        if card_number.present?
          '/cards/tokens'
        else
          '/bank_accounts/tokens'
        end
      end
    end

  end
end
