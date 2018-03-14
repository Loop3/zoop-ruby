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
