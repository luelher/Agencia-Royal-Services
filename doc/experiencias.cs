    public DataTable Reporte_Experiencia()
    {
      if(Conexion.State == ConnectionState.Open)
      {
        // 641.555   10842309

        DataTable dt = new DataTable();
        DataTable dtReporte = new DataTable();
        DataTable dt_nro_doc = new DataTable();
        DataRow dr;
      
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
              " docum_cc.monto_net  AS MtoFinanc " +
            " FROM " +
              " (docum_cc INNER JOIN clientes ON docum_cc.co_cli = clientes.co_cli) " +
              " INNER JOIN (factura INNER JOIN condicio ON factura.forma_pag = condicio.co_cond) ON docum_cc.nro_doc = factura.fact_num " +
            " WHERE " +
              " docum_cc.tipo_doc = 'FACT' AND condicio.dias_cred > 0 AND docum_cc.fec_emis < '" + _LaFecha.ToString("yyMMdd") + "'" +
              //" and clientes.co_cli='10842309'";
              "";

        clsBD.EjecutarQuery(strConexion_Profit_1,Conexion_Profit_1,SQL,out dt);

        Mensajes.Mensaje.Informar(dt.Rows.Count.ToString(),"Saint Reportes");

        #endregion

        if(dt.Rows.Count>0)
        {
          Factura RFactura;

                    dtReporte.Columns.Add("seleccion", System.Type.GetType("System.Boolean"));
          dtReporte.Columns.Add("Cedula",System.Type.GetType("System.String"));
          dtReporte.Columns.Add("Nombre",System.Type.GetType("System.String"));
          dtReporte.Columns.Add("Telefono",System.Type.GetType("System.String"));
          dtReporte.Columns.Add("Factura",System.Type.GetType("System.String"));
          dtReporte.Columns.Add("FechaE",System.Type.GetType("System.DateTime"));
          dtReporte.Columns.Add("MontoTotal",System.Type.GetType("System.Double"));
          dtReporte.Columns.Add("PagoMensual",System.Type.GetType("System.Double"));
          dtReporte.Columns.Add("Giros",System.Type.GetType("System.Byte"));
          dtReporte.Columns.Add("FechaCancelacion",System.Type.GetType("System.DateTime"));
          dtReporte.Columns.Add("Experiencia",System.Type.GetType("System.Byte"));
        
          for(int i=0;i<dt.Rows.Count;i++)
          {

            SQL = "SELECT " +
                  " docum_cc.nro_doc " +
                "FROM " +
                  " docum_cc " +
                "WHERE " +
                  " docum_cc.tipo_doc = 'CFXG' AND docum_cc.fec_emis = '" + Convert.ToDateTime(dt.Rows[i]["FechaE"].ToString()).ToString("yyMMdd") + "' AND docum_cc.co_cli = '" + dt.Rows[i]["CodClie"].ToString() + "'";
            clsBD.EjecutarQuery(strConexion_Profit_1,Conexion_Profit_1,SQL,out dt_nro_doc);

            if(dt_nro_doc.Rows.Count>0)
            {
              RFactura = ResumenFactura(dt_nro_doc.Rows[0]["nro_doc"].ToString(),dt.Rows[i]["CodClie"].ToString(),(DateTime)dt.Rows[i]["FechaE"]);

              RFactura.IDCliente = dt.Rows[i]["CodClie"].ToString();
              int CantGiros = Convert.ToInt32( dt.Rows[i]["NGiros"].ToString() )/30;
              //if(CantGiros>0) RFactura.PagoMensual  = Convert.ToDouble(dt.Rows[i]["MtoFinanc"].ToString())/CantGiros;

              RFactura.Giros = CantGiros;
              //RFactura.MontoTotal = Convert.ToDouble(dt.Rows[i]["MtoFinanc"].ToString());
              RFactura.FechaE = Convert.ToDateTime(dt.Rows[i]["FechaE"].ToString());
              //RFactura.FechaCancelacion = Convert.ToDateTime(dt.Rows[i]["FechaV"].ToString());
              RFactura.Cliente = dt.Rows[i]["Descrip"].ToString();

              if(RFactura.NroFactura !="")
              {
                dr = dtReporte.NewRow();
                                dr["seleccion"] = true;
                dr["Cedula"] = RFactura.IDCliente;
                dr["Nombre"] = RFactura.Cliente;
                dr["Telefono"] = RFactura.Telefono;
                dr["Factura"] = RFactura.NroFactura;
                dr["FechaE"] = RFactura.FechaE;
                dr["MontoTotal"] = RFactura.MontoTotal.ToString("########.##");
                dr["PagoMensual"] = RFactura.PagoMensual.ToString("########.##");
                dr["Giros"] = RFactura.Giros;
                dr["FechaCancelacion"] = RFactura.FechaCancelacion;
                dr["Experiencia"] = RFactura.Experiencia;
                dtReporte.Rows.Add(dr);
              }
            }
          }
          dtReporte.AcceptChanges();
          CerrarConexiones();
          return dtReporte;
        }
        else {CerrarConexiones(); return new DataTable();}
      }
      else {CerrarConexiones(); return new DataTable();}
    }



    