# frozen_string_literal: true

class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_for session_user if session_user
    user = session_user
    if user.present?
      user.online_status = 'Online'
      user.last_online = DateTime.now
      user.save
    end
  end

  def unsubscribed
    user = session_user
    if user.present?
      user.online_status = 'Offline'
      user.last_online = DateTime.now
      user.save
    end
  end
end
