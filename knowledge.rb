# Module implementing all functionality required by the koans.
class Module
  # Method 'attribute'which behaves much like the built-in 'attr',
  # but whose properties require delving  deep into the depths of meta-ruby.
  def attribute(argument, &block)

    argument, value = argument.first if argument.is_a? Hash

    define_method "#{argument}?" do
      send(argument)
    end

    define_method "#{argument}=" do |value|
      instance_variable_set("@#{argument}", value)
    end

    define_method argument do
      if instance_variable_defined?("@#{argument}")
        instance_variable_get("@#{argument}")
      else
        send("#{argument}=", block_given? ? instance_eval(&block) : value)
      end
    end
  end
end