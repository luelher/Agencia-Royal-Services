    public DataTable Reporte_Morosos(int desde, int hasta )
    {
      Conexion_Profit_1.Open();

      if(Conexion_Profit_1.State == ConnectionState.Open)
      {

        DataTable dt = new DataTable();
        DataTable dtReporte = new DataTable();
        DataTable dt_nro_doc = new DataTable();
        DataTable dt_fechas_cobros = new DataTable();
        DataRow dr;
        string cliente = "";
        bool hecho = false;
        int dias_ultimo_pago=0;
        Decimal meses=0;
        int resto = 0;

        DateTime fecha_ultimo_cobro;
      
        #region SQL Union Facturas

                SQL = " SELECT " +
          " docum_cc.co_cli     AS CodClie, " +
          " clientes.cli_des    AS Descrip, " +
          " clientes.direc1     AS Direc1, " +
          " clientes.direc2     AS Direc2, " +
          " clientes.telefonos  AS Telef, " +
          " docum_cc.nro_doc    AS NumeroD, " +
          " condicio.dias_cred  AS NGiros, " +
          " docum_cc.fec_emis   AS FechaE, " +
          " docum_cc.fec_venc   AS FechaV, " +
          " docum_cc.monto_net  AS MtoFinanc, " +
                    " zona.zon_des " +
          " FROM " +
                    " ((docum_cc INNER JOIN (clientes INNER JOIN zona ON clientes.co_zon=zona.co_zon ) ON docum_cc.co_cli = clientes.co_cli) " +
          " INNER JOIN (factura INNER JOIN condicio ON factura.forma_pag = condicio.co_cond) ON docum_cc.nro_doc = factura.fact_num) " +
          " WHERE " +
          " docum_cc.tipo_doc = 'FACT' AND condicio.dias_cred > 0 " +
          //" AND docum_cc.co_cli='7983524' " + 
          " ORDER BY " +
          " CodClie ASC;";

        clsBD.EjecutarQuery(strConexion_Profit_1,Conexion_Profit_1,SQL,out dt);

        Mensajes.Mensaje.Informar(dt.Rows.Count.ToString(),"Saint Reportes");

        #endregion

        if(dt.Rows.Count>0)
        {
          Factura RFactura;

                    dtReporte.Columns.Add("seleccion", System.Type.GetType("System.Boolean"));
          dtReporte.Columns.Add("cliente",System.Type.GetType("System.String"));
          dtReporte.Columns.Add("cedula",System.Type.GetType("System.String"));
          dtReporte.Columns.Add("direccion",System.Type.GetType("System.String"));
          dtReporte.Columns.Add("telefono",System.Type.GetType("System.String"));
          dtReporte.Columns.Add("meses",System.Type.GetType("System.Byte"));
          dtReporte.Columns.Add("saldo",System.Type.GetType("System.Double"));
          dtReporte.Columns.Add("ultcobro",System.Type.GetType("System.DateTime"));
          dtReporte.Columns.Add("dias",System.Type.GetType("System.Double"));
          dtReporte.Columns.Add("pagomensual",System.Type.GetType("System.String"));
                    dtReporte.Columns.Add("zona", System.Type.GetType("System.String"));

          for(int i=0;i<dt.Rows.Count;i++)
          {

            SQL = "SELECT " +
              " docum_cc.nro_doc " +
              "FROM " +
              " docum_cc " +
              "WHERE " +
              " docum_cc.tipo_doc = 'CFXG' AND docum_cc.fec_emis = '" + Convert.ToDateTime(dt.Rows[i]["FechaE"].ToString()).ToString("yyMMdd") + "' AND docum_cc.co_cli = '" + dt.Rows[i]["CodClie"].ToString() + "'";
            clsBD.EjecutarQuery(strConexion_Profit_1,Conexion_Profit_1,SQL,out dt_nro_doc);

            if(cliente != dt.Rows[i]["CodClie"].ToString())
            {
              cliente = dt.Rows[i]["CodClie"].ToString();
              hecho = true;
            }
            
            if(dt_nro_doc.Rows.Count>0 && hecho)
            {
              RFactura = ResumenFactura(dt_nro_doc.Rows[0]["nro_doc"].ToString(),dt.Rows[i]["CodClie"].ToString(),(DateTime)dt.Rows[i]["FechaE"]);

              if(!RFactura.Cancelada)
              {
                RFactura.IDCliente = dt.Rows[i]["CodClie"].ToString();
                int CantGiros = Convert.ToInt32( dt.Rows[i]["NGiros"].ToString() )/30;
                //if(CantGiros>0) RFactura.PagoMensual  = Convert.ToDouble(dt.Rows[i]["MtoFinanc"].ToString())/CantGiros;

                RFactura.Giros = CantGiros;
                //RFactura.MontoTotal = Convert.ToDouble(dt.Rows[i]["MtoFinanc"].ToString());
                RFactura.FechaE = Convert.ToDateTime(dt.Rows[i]["FechaE"].ToString());
                //RFactura.FechaCancelacion = Convert.ToDateTime(dt.Rows[i]["FechaV"].ToString());
                RFactura.Cliente = dt.Rows[i]["Descrip"].ToString();

                SQL = " SELECT cobros.fec_cob  " +
                  " FROM " +
                  " docum_cc INNER JOIN (reng_cob INNER JOIN cobros ON reng_cob.cob_num = cobros.cob_num) ON docum_cc.nro_doc = reng_cob.doc_num " +
                  " WHERE " +
                  " docum_cc.co_cli = '" + dt.Rows[i]["CodClie"].ToString() + "' " +
                  " ORDER BY " +
                  " cobros.fec_cob DESC ";
                clsBD.EjecutarQuery(strConexion_Profit_1,Conexion_Profit_1,SQL,out dt_fechas_cobros);

                if(dt_fechas_cobros.Rows.Count>0)
                {
                  fecha_ultimo_cobro=Convert.ToDateTime(dt_fechas_cobros.Rows[0][0].ToString());}
                else{fecha_ultimo_cobro=DateTime.MinValue;}

                dias_ultimo_pago = Analizar_FechaV(fecha_ultimo_cobro.ToString(),DateTime.Now);;

                resto = RFactura.Dias % 30;
                meses = Math.Abs(RFactura.Dias / 30);
                if(resto>0) meses++;

                if(RFactura.NroFactura !="" && (RFactura.GirosVencidosSinCancelar >=desde && RFactura.GirosVencidosSinCancelar <=hasta) && dias_ultimo_pago > 30 )
                {
                  dr = dtReporte.NewRow();
                                    dr["seleccion"] = true;
                  dr["cliente"] = RFactura.Cliente;
                  dr["cedula"] = RFactura.IDCliente;
                  dr["direccion"] = dt.Rows[i]["Direc1"].ToString();
                  dr["telefono"] = dt.Rows[i]["Telef"].ToString();

                  dr["meses"] = RFactura.GirosVencidosSinCancelar;

                  dr["saldo"] = RFactura.SaldoVencidoSinCancelar;
                  dr["ultcobro"] = fecha_ultimo_cobro;
                  dr["dias"] = dias_ultimo_pago;
                  dr["pagomensual"] = RFactura.PagoMensual.ToString("#########.00");

                                    dr["zona"] = dt.Rows[i]["zon_des"].ToString();

                  dtReporte.Rows.Add(dr);
                  hecho = false;
                }
              }
            }
          }
          dtReporte.AcceptChanges();
          CerrarConexiones();
          return dtReporte;
        }else {CerrarConexiones(); return new DataTable();}
      }
      else {CerrarConexiones(); return new DataTable();}
    }