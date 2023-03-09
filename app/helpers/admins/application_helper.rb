module Admins::ApplicationHelper
  def activated_nav_link
    current_controller = controller.controller_name
    if %w[flights flight_classes].include?(current_controller)
      :flights
    elsif %w[aeroplanes aeroplane_classes].include?(current_controller)
      :aeroplanes
    else
      :home
    end
  end
end
