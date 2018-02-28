module Zoop
  class Token < Zoop::Model

    def create
      @custom_url = self.class.url(self.card_number.present?)
      super
    end

    def destroy
      raise NotImplementedError
    end

    class << self

      def url(*params)
        case params.first
        when TrueClass then '/cards/tokens'
        when FalseClass then '/bank_accounts/tokens'
        else super(*params)
        end
      end
    end

  end
end
