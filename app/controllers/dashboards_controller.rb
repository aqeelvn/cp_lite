class DashboardsController < ApplicationController
  before_action :require_login

  def show
    @feed_items = current_user.feed_items
      .order(created_at: :desc)
      .includes(
        :user_activity,
        { user_activity: :user},
        { user_activity: :target}
      )
  end
end
