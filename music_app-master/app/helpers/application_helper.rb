module ApplicationHelper

  def display_object_errors(object)

    <<-HTML.html_safe
      <pre>
        #{object.errors.full_messages.join("\n")}
      </pre>
    HTML
  end

  def authentic_form
    <<-HTML.html_safe
      <input type="hidden"
      name="authenticity_token"
      value="#{form_authenticity_token}">
    HTML
  end

  def my_button_to(url, text, method = 'post')
    <<-HTML.html_safe
    <form action="#{url}" method="post">
      <input type="hidden" name="_method" value="#{method}">
      #{authentic_form}
      <button> #{text} </button>
    </form>
    HTML
  end

  def my_link_to(url, text)
    <<-HTML.html_safe
      <a href="#{url}"> #{text} </a>
    HTML
  end


  def secret_patch
    <<-HTML.html_safe
    <input type="hidden" name="_method" value="patch">
    HTML
  end




end
