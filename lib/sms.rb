class Sms
  CUENTA_TOKEN = "400488a3a8e0f5aed77d0bcc06614e74"
  SUBCUENTA_TOKEN = "f98a5c4b2dd2e61553faa0987a319622"

  def self.run_sms_server()
    sms = Textveloper::Sdk.new(CUENTA_TOKEN,SUBCUENTA_TOKEN)

    for_send = Sms::Outbox.where(:processed => false).order(:insertdate).limit(5)

    for_send.each do |msj|

      result = sms.send_sms(msj.number.gsub("+58","0"),msj.text)
      msj.processed_date = Time.now
      msj.processed = true
      if result.count > 0
        # puts result.first.to_json
        if result.first[1]["transaccion"] == "exitosa"
          msj.error = 0
        else
          msj.error = 8
        end
      else
        msj.error = 6
      end
      msj.save
    end
  end

end