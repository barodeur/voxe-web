module Moped
  module BSON
    class ObjectId
      alias :to_json :to_s
      alias :as_json :to_s
    end
  end
end

module BSON
  class ObjectId
    alias :to_json :to_s
    alias :as_json :to_s
  end
end
