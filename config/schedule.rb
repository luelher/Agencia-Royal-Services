# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :output, File.join(Whenever.path, "config", "schedule.log")


every 10.minutes do
  runner "Gmining::ProfitClient.run_mining(10)"
end

every 1.minute do
  runner "Sms.run_sms_server()"
end

every :sunday, :at => '08am' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,0)"
end

every :sunday, :at => '09am' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,1000)"
end

every :sunday, :at => '10am' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,2000)"
end

every :sunday, :at => '11am' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,3000)"
end

every :sunday, :at => '01pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,4000)"
end

every :sunday, :at => '02pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,5000)"
end

every :sunday, :at => '03pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,6000)"
end

every :sunday, :at => '04pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,7000)"
end

every :sunday, :at => '05pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,8000)"
end

every :sunday, :at => '06pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,9000)"
end

every :sunday, :at => '07pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,9000)"
end

every :sunday, :at => '08pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,10000)"
end

every :sunday, :at => '09pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,11000)"
end

every :sunday, :at => '10pm' do
  runner "Cobranza::Experiencia.calcular_experiencias(1000,12000)"
end




