class Sms
  CUENTA_TOKEN = "400488a3a8e0f5aed77d0bcc06614e74"
  SUBCUENTA_TOKEN = "f98a5c4b2dd2e61553faa0987a319622"

  def self.run_sms_server()
    sms = Textveloper::Sdk.new(CUENTA_TOKEN,SUBCUENTA_TOKEN)

    log = Logger.new('sms.log')

    if Sms::connection?

      balance = Sms::balance

      if balance > 0
        for_send = Sms::Outbox.where(:processed => false).order(:insertdate).limit(5)

        for_send.each do |msj|
          if balance > 0
            result = sms.send_sms(msj.number.gsub("+58","0"),msj.text)
            msj.processed_date = Time.now
            msj.processed = true
            if result.count > 0
              # puts result.first.to_json
              if result.first[1]["transaccion"] == "exitosa"
                msj.error = 0
                log.debug "Enviado Nro: #{msj.number.gsub("+58","0")}, a las #{msj.processed_date.to_s}"
              else
                msj.error = 8
                log.debug "Error del API. Nro: #{msj.number.gsub("+58","0")}, a las #{msj.processed_date.to_s}, #{result.first[1]['mensaje_transaccion']}"
              end
            else
              msj.error = 6
              log.debug "Error del API. Nro: #{msj.number.gsub("+58","0")}, a las #{msj.processed_date.to_s}, #{result.first[1]['mensaje_transaccion']}"
            end
            msj.save

            balance-=1
          else
            log.debug "Sin Balance, a las #{msj.processed_date.to_s}"
            false
          end
        end
        true
      else
        log.debug "Sin Balance, a las #{msj.processed_date.to_s}"
        false
      end
      true
    else
      log.debug "Sin Conexion"
      false
    end
  end

  def self.balance
    begin
      account = Textveloper::Sdk.new(CUENTA_TOKEN,SUBCUENTA_TOKEN)
      balance = account.account_balance
      if balance.count > 0
        return balance["puntos_disponibles"].to_i
      else
        return 0
      end
    rescue
      return 0
    end
  end

  def self.connection?
    begin
      account = Textveloper::Sdk.new(CUENTA_TOKEN,SUBCUENTA_TOKEN)
      balance = account.account_balance
      if balance.count > 0
        return true
      else
        return false
      end
    rescue
      return false
    end
  end

end