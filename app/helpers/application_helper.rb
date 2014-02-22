module ApplicationHelper


  def flash_messages
    html = ""
    flash.each do |key, value|
      html << content_tag(:div, link_to("x", "#", :'data-dismiss' => "alert", :class => "close") + raw(value), :class => "alert alert-#{key}")
    end
    
    html.html_safe
  end
  
end
