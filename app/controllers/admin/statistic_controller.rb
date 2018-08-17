class Admin::StatisticController < ApplicationController
  def index
    @cost_electric = Cost.statistic_electric
    @cost_water = Cost.statistic_water
    @months = Cost.get_months
    respond_to do |format|
      format.json {
        render json: [{year: DateTime.now.year.to_s}, [{name: t(".electric"), data: @cost_electric},
          {name: t(".water"), data: @cost_water}], {months: @months}]
      }
    end
  end
end
