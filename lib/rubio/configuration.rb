module Rubio
  class Configuration
    OPTIONS = [:rdio_key, :rdio_secret, :timeout]

    class << self
      def create_options
        OPTIONS.each do |option|
          self.instance_eval <<-RUBY, __FILE__, __LINE__+1
            def #{option.to_s}(value=nil)
              @#{option.to_s} = value if value
              @#{option.to_s}
            end
          RUBY
        end
      end

      def configure(&block)
        block.arity < 1 ? instance_eval(&block) : block.call(self)
      end
    end
  end
end