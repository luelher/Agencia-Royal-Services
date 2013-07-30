module InformeHelper
  def select_month_tag
    begining = "2013-01-01".to_date

    #select_tag :mes
    select_month(Date.today)
  end
end
