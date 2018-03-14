module Zoop
  class NestedModel < Model

    def create
      @custom_url = self.class.url(parent_id)
      super
    end

    def url(*params)
      raise RequestError.new('Invalid ID') unless id.present?
      self.class.url parent_id, CGI.escape(id.to_s), *params
    end

    class << self

      def parent_resource_name
        raise NotImplementedError
      end

      def find_by_id(parent_id:, id:)
        raise RequestError.new('Invalid ID')        unless        id.present?
        raise RequestError.new('Invalid parent ID') unless parent_id.present?

        Zoop::Request.get(url parent_id, id).call
      end
      alias :find :find_by_id

      def url(parent_id, *params)
        raise RequestError.new('Invalid parent ID') unless parent_id.present?
        ["/#{parent_resource_name}", parent_id, "#{ CGI.escape underscored_class_name }s", *params].join '/'
      end
    end

    protected

    def parent_id
      raise NotImplementedError
    end
  end
end