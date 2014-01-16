ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    section "Recently updated content" do
        table_for PaperTrail::Version.order('id desc').limit(20) do # Use PaperTrail::Version if this throws an error
            column "Item" do |v| link_to v.item, v.item.admin_permalink end
            # column "Item" do |v| link_to v.item, [:admin, v.item] end # Uncomment to display as link
            column "Type" do |v| v.item_type.underscore.humanize end
            column "Modified at" do |v| v.created_at.to_s :long end
            column "Admin" do |v| link_to User.find(v.whodunnit).email, admin_user_path(User.find(v.whodunnit)) end
        end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
