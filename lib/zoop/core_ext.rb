class Object
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end

  def present?
    !blank?
  end
end

class String
  def convert_to_cents
    (self.to_f * 100).to_i
  end
end

class Hash
  def deep_compact
    delete_if {|k,v| v.deep_compact if v.is_a?(Hash); v.nil?}
  end
end
