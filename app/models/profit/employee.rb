class Profit::Employee < ActiveRecord::Base
  establish_connection "adminprofit_#{Rails.env}"
  self.table_name = 'employee'
  # attr_accessible :title, :body

  def self.migrar_usuarios
    devise_users = User.all.map{|u| u.profit}
    devise_users << "001   "
    devise_users << "999   "
    employee = Profit::Employee.where("employee_i NOT IN (?)",devise_users)

    employee.each do |e|
      devise = User.new
      devise.profit = e.employee_i
      devise.username = e.employee_i.strip
      devise.name = e.last_name.strip
      devise.email = e.employee_i.strip + "@agenciaroyal.com"
      devise.password = "123456"
      devise.role_id = Role.find_by_name("vendedores").id
      devise.save
      puts devise.errors.full_messages
    end
    true
  end

end
