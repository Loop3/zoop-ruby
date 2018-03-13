module Zoop
  class Model < ZoopObject

    def create
      update_model Zoop::Request.post(@custom_url || self.class.url, params: to_hash).run
      self
    end

    def update(params={})
      update_model Zoop::Request.put(@custom_url || url, params: params).run
      self
    end

    def save
      update_model Zoop::Request.put(@custom_url || url, params: unsaved_attributes).run
      self
    end

    def destroy
      update_model Zoop::Request.delete(url).run
      self
    end

    def url(*params)
      raise RequestError.new('Invalid ID') unless id.present?
      self.class.url CGI.escape(id.to_s), *params
    end

    class << self

      def create(*args, &block)
        self.new(*args, &block).create
      end

      def find_by_id(id)
        raise RequestError.new('Invalid ID') unless id.present?
        Zoop::Request.get(url id).call
      end
      alias :find :find_by_id

      def url(*params)
        ["/#{ CGI.escape underscored_class_name }s", *params].join '/'
      end

      def class_name
        self.name.split('::').last
      end

      def underscored_class_name
        class_name.gsub(/[a-z0-9][A-Z]/){|s| "#{s[0]}_#{s[1]}"}.downcase
      end
    end

  end
end