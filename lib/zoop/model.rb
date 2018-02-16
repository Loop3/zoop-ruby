module Zoop
  class Model < ZoopObject

    def create
      update Zoop::Request.post(self.class.url, params: to_hash).run
      self
    end

    def save
      update Zoop::Request.put(url, params: unsaved_attributes).run
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

      def find_by(params = Hash.new, page = nil, count = nil)
        params = extract_page_count_or_params(page, count, **params)
        raise RequestError.new('Invalid page count') if params[:page] < 1 or params[:count] < 1

        Zoop::Request.get(url, params: params).call
      end
      alias :find_by_hash :find_by

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