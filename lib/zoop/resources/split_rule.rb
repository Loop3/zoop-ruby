module Zoop
  class SplitRule < Zoop::NestedModel

    class << self

      def parent_resource_name
        'transactions'
      end
    end

    protected

    def parent_id
      self.transaction
    end

  end
end
