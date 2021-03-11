module GoodJob
  module ApplicationHelper
    def flash_class(key)
      rails_to_bootstrap = {
        alert: :warning,
        error: :danger,
        notice: :info,
        success: :success,
      }

      rails_class = key
      bootstrap_class = rails_to_bootstrap[key]

      "flash flash-#{rails_class} alert alert-#{bootstrap_class}"
    end
  end
end
