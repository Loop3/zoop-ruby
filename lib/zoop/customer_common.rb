module Zoop
  class CustomerCommon < Model

    class << self

      def find_by_document(document)
        raise RequestError.new('Invalid CPF/CNPJ') unless document.present?

        raw_document = document.scan(/[0-9]/).join
        document_type = raw_document.size <= 11 ? :taxpayer_id : :ein

        Zoop::Request.get(
          url('search'),
          headers: { 'Content-type' => '' },
          query: { document_type => raw_document }
        ).call
      end
    end

  end
end
