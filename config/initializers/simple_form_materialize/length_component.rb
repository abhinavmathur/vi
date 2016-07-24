module SimpleForm
  module Materialize
    module Components
      module Length
        # This method has been added for the Materialize character count.
        def length(wrapper_options = nil)
          input_html_options[:length] ||= maximum_length_from_validation || limit
          nil
        end

        private

        def maximum_length_from_validation
          maxlength = options[:maxlength]
          if maxlength.is_a?(String) || maxlength.is_a?(Integer)
            maxlength
          else
            length_validator = find_length_validator

            if length_validator && !has_tokenizer?(length_validator)
              length_validator.options[:is] || length_validator.options[:maximum]
            end
          end
        end

        def find_length_validator
          find_validator(:length)
        end

        def has_tokenizer?(length_validator)
          length_validator.options[:tokenizer]
        end
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Materialize::Components::Length)
