module Zoop
  class Token < Zoop::Model

    def create
      @custom_url = self.class.url(self.card_number)
      super
    end

    def destroy
      raise NotImplementedError
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
