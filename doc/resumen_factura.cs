    private Factura ResumenFactura(string idFactura,string idCliente,DateTime FechaE)
    {
      DataTable dtCxC = new DataTable();
      DataTable dtGiro = new DataTable();
      string str="";
      Factura Resumen;

      SQL=  "SELECT " +
            " Docum_cc.co_cli     AS CodClie, " +
            " Clientes.cli_des    AS Descrip, " +
            " Docum_cc.nro_doc    AS NroUnico, " +
            " Docum_cc.nro_orig   AS NroRegi, " +
            " Docum_cc.fec_emis   AS FechaE, " +
            " Docum_cc.fec_venc   AS FechaV, " +
            " Docum_cc.doc_orig   AS TipoCxc, " +
            " Docum_cc.monto_net  AS Monto, " +
            " Docum_cc.nro_doc    AS NumeroD, " +
            " Docum_cc.saldo      AS Saldo, " +
            " Docum_cc.saldo      AS SaldoAct, " +
            " MIN(Docum_cc.monto_net) AS Giro, " + 
            " SUM(Docum_cc.monto_net) as Total, " +
            " SUM(Docum_cc.saldo) as SaldoT " +
          " FROM " +
            " Docum_cc INNER JOIN Clientes ON Docum_cc.co_cli = Clientes.co_cli " +
          " WHERE " +
            " Docum_cc.nro_orig = " + idFactura + " AND docum_cc.tipo_doc = 'GIRO' " +
          " GROUP BY " +
            " Docum_cc.co_cli, " +
            " Clientes.cli_des, " +
            " Docum_cc.nro_doc, " +
            " Docum_cc.nro_orig, " +
            " Docum_cc.fec_emis, " +
            " Docum_cc.fec_venc, " +
            " Docum_cc.doc_orig, " +
            " Docum_cc.monto_net, " +
            " Docum_cc.nro_doc, " +
            " Docum_cc.saldo, " +
            " Docum_cc.saldo " +
          " ORDER BY " +
            " Docum_cc.nro_doc ASC  ";

      clsBD.EjecutarQuery(strConexion_Profit_1,Conexion_Profit_1,SQL,out dtCxC);

      SQL=  "SELECT " +
        " min(Docum_cc.monto_net) AS Giro, SUM(Docum_cc.monto_net) as Total, SUM(Docum_cc.saldo) as Saldo " +
        " FROM " +
        " Docum_cc INNER JOIN Clientes ON Docum_cc.co_cli = Clientes.co_cli " +
        " WHERE " +
        " Docum_cc.nro_orig = " + idFactura + " AND docum_cc.tipo_doc = 'GIRO' ";

      clsBD.EjecutarQuery(strConexion_Profit_1,Conexion_Profit_1,SQL,out dtGiro);

      Resumen = new Factura("");

      public string NroFactura;
      public DateTime FechaE;
      public double MontoTotal;
      public double Impuesto;
      public double MontoNeto;
      public double Adelanto;
      public double Intereses;
      public double PagoMensual;
      public int Giros;
      public DateTime FechaCancelacion;
      private byte _Experiencia;
      public int Dias;
      public bool Cancelada;
      public double Saldo;
      public double SaldoVencido;
      public double SaldoRestante;
      public int GirosSinCancelar;
      public double SaldoVencidoSinCancelar;
      public int GirosVencidosSinCancelar;

      Resumen.Experiencia = 254;

      if(dtCxC.Rows.Count>0)
      {
        int Cuota=0;
        int Total=0;
        int Dias =0;
        double Monto=0.0;
        string strMonto;
        string cedula;
        bool experiencia = false;
        DateTime fechaVenc;
        str = dtCxC.Rows[0]["NumeroD"].ToString();

        cedula = dtCxC.Rows[0]["CodClie"].ToString();

        //if(cedula == "7420758" || cedula == "12698405" || cedula == "4373147")
        //  cedula = "xxx";

        Resumen = new Factura(str = idFactura);
        Resumen.Cliente = dtCxC.Rows[0]["Descrip"].ToString();
        Resumen.MontoTotal = 0.0;

        //if(dtGiro.Rows.Count>0)
        //{
          Resumen.PagoMensual = Convert.ToDouble(dtGiro.Rows[0]["Giro"].ToString());
          Resumen.MontoTotal = Convert.ToDouble(dtGiro.Rows[0]["Total"].ToString());
          Resumen.Saldo = Convert.ToDouble(dtGiro.Rows[0]["Saldo"].ToString());
          if(Convert.ToDouble(Resumen.Saldo)==0.0)
            Resumen.Cancelada = true;
          else Resumen.Cancelada = false;
        //}

        Total = dtCxC.Rows.Count;
        for(int i=0;i<dtCxC.Rows.Count;i++)
        {
          if(Convert.ToDouble(dtCxC.Rows[i]["Saldo"].ToString())>0.0)
          {
            Resumen.GirosSinCancelar++;
            Resumen.SaldoRestante = Convert.ToDouble(dtCxC.Rows[i]["Saldo"].ToString());

            fechaVenc = Convert.ToDateTime(dtCxC.Rows[i]["FechaV"].ToString());
            if(fechaVenc<DateTime.Now){
              Resumen.GirosVencidosSinCancelar++;
              Resumen.SaldoVencidoSinCancelar += Convert.ToDouble(dtCxC.Rows[i]["Saldo"].ToString());
            }

          }

          //str = dtCxC.Rows[i]["NumeroD"].ToString();
          //Analizar_TipoCxc(str,ref Cuota,ref Total);
          Cuota = i+1;

          

          DateTime FE = Convert.ToDateTime(dtCxC.Rows[i]["FechaE"].ToString());

          Dias = Analizar_FechaV(dtCxC.Rows[i]["FechaV"].ToString(),DateTime.Now);
          strMonto = dtCxC.Rows[i]["Saldo"].ToString();
          Monto = Convert.ToDouble(strMonto);

          Resumen.Dias = Dias;

          if((Monto!=0.0 || Dias == -1) && !experiencia)
          {
            if (Dias == -1)
              Resumen.Experiencia = 0;
            else if (Dias>=0 && Dias<30)
              Resumen.Experiencia = 2;
            else if (Dias>=30 && Dias<60)
              Resumen.Experiencia = 3;
            else if (Dias>=60 && Dias<90)
              Resumen.Experiencia = 4;
            else if (Dias>=90 && Dias<120)
              Resumen.Experiencia = 5;
            else if (Dias>=120 && Dias<=365)
              Resumen.Experiencia = 20;
                        else if (Dias>365)
                            Resumen.Experiencia = 21;
            else if (Dias < 0 && FE.Month != _LaFecha.Month && FE.Year != _LaFecha.Year)
              Resumen.Experiencia = 1;
            experiencia=true;
          }
          else 
          {
            if(!experiencia)
            {
              Resumen.Experiencia = 1;

              if(Cuota==Total && Monto == 0.0 )
              {
                DataTable dtFechaC = new DataTable();
                string F = "";

                DateTime FV = Convert.ToDateTime(dtCxC.Rows[i]["FechaV"].ToString());

                SQL= " SELECT " +
                  "cobros.fec_cob  " +
                  " FROM " +
                  "reng_cob INNER JOIN cobros ON reng_cob.cob_num = cobros.cob_num " +
                  " WHERE " +
                  "reng_cob.doc_num = '" + dtCxC.Rows[i]["NroUnico"].ToString() + "' " +
                  "ORDER BY " +
                  "cobros.fec_cob DESC ";

                clsBD.EjecutarQuery(strConexion_Profit_1,Conexion_Profit_1,SQL,out dtFechaC);

                if(dtFechaC.Rows.Count>0)
                {
                  try
                  {
                    F = dtFechaC.Rows[0][0].ToString();
                    if (F.Trim()!="") Resumen.FechaCancelacion = Convert.ToDateTime(F);
                  }
                  catch
                  {Mensajes.Mensaje.Error(dtFechaC.Rows[0][0].ToString(),"Saint");}
                }
              }
            }
          }
          
        }
        return Resumen;
      }
      else return Resumen;
    }