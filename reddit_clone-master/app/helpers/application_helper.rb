module ApplicationHelper

  def authentic_form
    <<-HTML.html_safe
      <input
        type="hidden"
        name="authenticity_token" value="#{form_authenticity_token}">
    HTML
  end

  def my_button_to(url, text, method = 'POST')
    <<-HTML.html_safe
      <form class="" action="#{url}" method="post">
        <input type="hidden" name="_method" value="#{method}">
        #{authentic_form}
        <button>#{text}</button>
      </form>
    HTML
  end

  def secret_method(method)
    <<-HTML.html_safe
      <input type="hidden" name="_method" value="#{method}">
    HTML
  end

  def my_link_to(url, text)
    <<-HTML.html_safe
      <a href="#{url}">#{text}</a>
    HTML
  end

  def submit_option(object)
    object.persisted? ? "Update" : "Create"
  end

  def object_errors(object)
    <<-HTML.html_safe
      <ul>
        <li>#{object.errors.full_messages.join("</li> <li>")}</li>
      </ul>
    HTML
  end

end
