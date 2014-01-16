module InformeHelper
  def select_month_tag
    begining = "2013-01-01".to_date

    #select_tag :mes
    select_month(Date.today)
  end

  def select_year_tag
    begining = "2013-01-01".to_date

    #select_tag :mes
    select_year(Date.today, :start_year => Date.today.year - 3, :end_year => Date.today.year)
  end

end
