class Gmining::ProfitClient

  ACCOUNT = "519db367152d761884000001"

  def initialize
    @v1 = Gmining::V1.new
    @otros = 0.0
    @giros = 0.0
    @iniciales = 0.0
    @sales = []
    @account = ""
    @clientes = []
    @vendedores = []
    @log = Logger.new('migration.log')
  end

  def sales
    @sales
  end

  def get_sales(desde, hasta)

    # revenue

    # Total facturado Otros
    sql = "select 
              sum(tot_bruto) as total, 
              fec_emis 
            from 
              factura 
            where 
              forma_pag='01' 
              and fe_us_in > '#{desde.strftime("%Y-%m-%d %H:%M:%S")}' 
              and fe_us_in <= '#{hasta.strftime("%Y-%m-%d %H:%M:%S")}' 
            group by 
              fec_emis 
            order by 
              fec_emis desc"

    result = Profit::Factura.connection.select_all(sql)


    @otros = result.first["total"].to_f unless result.first.nil?

    # Total cobrado por Giros
    sql = "select 
            SUM(r.neto) as total, 
            c.fec_cob 
          from 
            reng_cob r inner join cobros c on r.cob_num=c.cob_num 
          where 
            r.tp_doc_cob='GIRO' 
            and c.fe_us_in > '#{desde.strftime("%Y-%m-%d %H:%M:%S")}' 
            and c.fe_us_in <= '#{hasta.strftime("%Y-%m-%d %H:%M:%S")}' 
          group by 
            c.fec_cob 
          order by 
            c.fec_cob desc"

    result = Profit::Factura.connection.select_all(sql)

    @giros = result.first["total"].to_f unless result.first.nil?

    # Total de Iniciales
    sql = "select 
            SUM(r.neto) as total, 
            c.fec_cob 
          from 
            reng_cob r inner join cobros c on r.cob_num=c.cob_num 
          where 
            r.tp_doc_cob='CFXG' 
            and c.fe_us_in > '#{desde.strftime("%Y-%m-%d %H:%M:%S")}' 
            and c.fe_us_in <= '#{hasta.strftime("%Y-%m-%d %H:%M:%S")}' 
          group by 
            c.fec_cob 
          order by 
            c.fec_cob desc"

    result = Profit::Factura.connection.select_all(sql)

    @iniciales = result.first["total"].to_f unless result.first.nil?

    if @otros+@giros+@iniciales > 0
      @sales << { account: ACCOUNT, time: hasta, dtype: "revenue", data: { values: { total: (@otros+@giros+@iniciales).to_f, otros: @otros.to_f, giros: @giros.to_f, iniciales: @iniciales.to_f } } }
    end

    # Clientes

    # Top 5 de clientes

    sql = "select top 5 
            f.co_cli, 
            c.cli_des, 
            f.fe_us_in, 
            f.tot_neto  
          from 
            factura f inner join clientes c on f.co_cli=c.co_cli 
          where
            f.fe_us_in > '#{desde.strftime("%Y-%m-%d %H:%M:%S")}' 
            and f.fe_us_in <= '#{hasta.strftime("%Y-%m-%d %H:%M:%S")}'
          order by 
            f.fe_us_in desc"

    result = Profit::Factura.connection.select_all(sql)

    @clientes = result

    unless @clientes.empty?
      cli = []
      @clientes.each do |c|
        cli << {code: c["co_cli"].strip, timestamp: c["fe_us_in"], id: c["co_cli"].strip, name: c["cli_des"].strip, amount: c["tot_neto"].to_f}
      end

      @sales << {
                  account: ACCOUNT, 
                  time: hasta, 
                  dtype: "last_clients", 
                  data: cli
                }
    end

    # Top 5 de Vendedoras
    sql = "select top 5 
            v.co_ven, 
            v.ven_des, 
            sum(f.tot_neto) as total 
          from 
            factura f inner join vendedor v on f.co_ven=v.co_ven 
          where 
            f.fe_us_in > '#{desde.strftime("%Y-%m-%d %H:%M:%S")}' 
            and f.fe_us_in <= '#{hasta.strftime("%Y-%m-%d %H:%M:%S")}'
          group by 
            v.co_ven, 
            v.ven_des"
    result = Profit::Factura.connection.select_all(sql)

    @vendedores = result

    unless @vendedores.empty?
      sell = []
      @vendedores.each do |v|
        sell << {code: v["co_ven"].strip ,name: v["ven_des"].strip, amount: v["total"].to_f}
      end

      @sales << {
                  account: ACCOUNT, 
                  time: hasta, 
                  dtype: "top_sellers", 
                  data: sell
                }
    end

  end

  def send(fecha)
    
    if @sales.count > 0
      http = Gmining::V1.new
      result = http.post "/v1/sales", @sales
      # log 
      @log.debug fecha.to_s + ": " + result.to_s
      result
    end
    
  end

  def migrate_data

    from = "2010-01-01 06:00:00 0000".to_time
    to = "2010-05-01 00:00:00 0000".to_time

    (1..(to.to_date.mjd - from.to_date.mjd)).each do |d|
      dia = (from + d.day)
      (1..12).each do |h|
        profit = Gmining::ProfitClient.new
        profit.get_sales (dia + h.hour), (dia + (h+1).hour)
        profit.send (dia + (h+1).hour)
      end
    end

  end

end