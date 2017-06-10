module ApplicationHelper
  def avatar(user, size:)
    image_tag user.avatar.url(size), class: "avatar round-image"
  end

  def follow_button(user)
    if current_user.follows?(user)
      button_to t("unfollow"), [:unfollow, user]
    else
      button_to t("follow"), [:follow, user]
    end
  end

  def link_to_add_nested(text, form, association)
    singulare_name = association.to_s.singularize
    object = form.object.public_send(association).build
    template = form.fields_for(association, object, child_index: "__ID__") do |nested_form|
      render "#{singulare_name}_fields", form: nested_form
    end

    link_to text, "#", data: { role: "add-nested", template: template }
  end
end
