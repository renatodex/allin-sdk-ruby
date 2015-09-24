module Helpers
  module Builder
    def build_fields(merge_data)
      merge_data.keys.join(";")
    end

    def build_values(merge_data)
      merge_data.values.join(";")
    end
  end
end
