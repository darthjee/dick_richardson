module RSpec
  module Matchers
    module Custom
      class BeJsonLike < RSpec::Matchers::BuiltIn::BaseMatcher
        attr_reader :target, :actual

        def initialize(target)
          @target = target
        end

        def matches?(actual)
          @actual = actual
          JSON.parse(actual) == JSON.parse(target)
        end

        def description
          "'#{actual}' be json like #{target}"
        end

         def supports_block_expectations?
           false
         end
      end

      def be_json_like(json)
        BeJsonLike.new(json)
      end
    end
  end
end
