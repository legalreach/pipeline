module PipelineActionControllerExtension
    def self.included(base)
        base.send(:include, InstanceMethods) 
        #base.before_filter :my_method_1
        #base.after_filter :my_method_2
    end

    module InstanceMethods
        
        PIPELINE_JS_ESCAPE_MAP          = { '\\' => '\\\\', '</' => '<\/', "\r\n" => '\n', "\n" => '\n', "\r" => '\n', '"' => '\\"', "'" => "\\'" }
        PIPELINE_JS_SECOND_ESCAPE_MAP   = {  "\n" => ' ', "\r" => ' ', '\t' => ' ' }

        def render_for_pipeline(partial, locals)
            if !partial.blank?
              rendered_view = render_to_string(:partial => partial, :locals => locals[:locals])
              rendered_view = rendered_view.gsub(/\\|<\/|\r\n|[\n\r\"\']/) {|match| PIPELINE_JS_ESCAPE_MAP[match] }
            else
              rendered_view = ""
            end

            onload = yield rendered_view

            render :json => {
                :onload => onload.gsub(/[\n\t\r]/) {|match| PIPELINE_JS_SECOND_ESCAPE_MAP[match] }
            }
        end
    end
end