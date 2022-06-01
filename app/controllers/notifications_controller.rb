class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
#未確認の通知レコードだけ取り出したあと、「未確認→確認済」になるように更新をする。