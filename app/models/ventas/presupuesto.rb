class Ventas::Presupuesto < ActiveRecord::Base
  self.table_name = 'presupuestos'

  attr_accessible :cliente_id, :instalacion, :inicial, :giros, :cuota, :giros_especiales, :cuota_especial, :vendedor, :aprobado_por
  attr_accessible :detalle_presupuesto_attributes
  # attr_accessible :producto, :cantidad, :total
  
  belongs_to :cliente, :class_name => "Ventas::Cliente"
  has_many :detalle_presupuesto, {:class_name => "Ventas::DetallePresupuesto", :inverse_of => :presupuesto}

  before_save :inicializar_save
  after_save :crear_presupuesto_profit

  accepts_nested_attributes_for :detalle_presupuesto

  validates :detalle_presupuesto, :instalacion, :inicial, :giros, :giros_especiales,  :presence => true

  def inicializar_save
    self.vendedor = '17637071'
  end

  def total
    detalle_presupuesto.sum(&:total)
  end

  def to_string
    self.id
  end

  def producto
    @producto
  end

  def producto(producto)
    @producto |= producto
  end

  def cantidad
    @cantidad
  end

  def cantidad(cantidad)
    @cantidad |= cantidad
  end

  def total=(total)
    @total |= total
  end

  def crear_presupuesto_profit    

    # cotiz_c
    # exec sp_executesql N'INSERT INTO cotiz_c (fact_num,contrib,status,descrip,saldo,fec_emis,fec_venc,co_cli,co_ven,co_tran,forma_pag,tot_bruto,tot_neto,glob_desc,tot_reca,tot_flete,iva,feccom,tasa,moneda,tasag,tasag10,tasag20,co_us_in,fe_us_in,co_us_mo,fe_us_mo,co_us_el,fe_us_el,revisado,trasnfe,co_sucu,otros1) VALUES (@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10,@P11,@P12,@P13,@P14,@P15,@P16,@P17,@P18,@P19,@P20,@P21,@P22,@P23,@P24,@P25,@P26,@P27,@P28,@P29,@P30,@P31,@P32,@P33)',N'


    # @P1 int
    # @P2 bit
    # @P3 char(1)
    # @P4 varchar(60)
    # @P5 decimal(18,2)
    # @P6 smalldatetime
    # @P7 smalldatetime
    # @P8 char(10)
    # @P9 char(6)
    # @P10 char(6)
    # @P11 char(6)
    # @P12 decimal(18,2)
    # @P13 decimal(18,2)
    # @P14 decimal(18,2)
    # @P15 decimal(18,2)
    # @P16 decimal(18,2)
    # @P17 decimal(18,2)
    # @P18 smalldatetime
    # @P19 decimal(18,5)
    # @P20 char(6)
    # @P21 decimal(18,5)
    # @P22 decimal(18,5)
    # @P23 decimal(18,5)
    # @P24 char(4)
    # @P25 datetime
    # @P26 char(4)
    # @P27 datetime
    # @P28 char(4)
    # @P29 datetime
    # @P30 char(1)
    # @P31 char(1)
    # @P32 char(6)
    # @P33 decimal(18,5)


    # 25
    # 1
    # '0'
    # 'Venta a credito cliente nuevo '
    # 4747.50
    # ''2013-02-26 00:00:00:000''
    # ''2013-02-26 00:00:00:000''
    # '14797965 '
    # '07 '
    # '04 '
    # '24 '
    # 4238.84
    # 4747.50
    # 0
    # 0
    # 0
    # 508.66
    # ''2013-02-26 00:00:00:000''
    # 1.00000
    # 'BSF '
    # 12.00000
    # 12.00000
    # 0
    # '002 '
    # ''2013-02-26 23:30:38:000''
    # ' '
    # ''2013-02-26 23:30:38:000''
    # ' '
    # ''2013-02-26 23:30:38:000''
    # ' '
    # ' '
    # '01 '
    # 0    

    par_emp = Profit::ParEmp.last

    cotizacion = Profit::CotizC.new

    total = self.total

    cotizacion.fact_num = par_emp.cotc_num + 1
    cotizacion.contrib = 1
    cotizacion.status = '0'
    cotizacion.descrip = ''
    cotizacion.saldo = total
    cotizacion.fec_emis = Time.now
    cotizacion.fec_venc = Time.now + 2.days
    cotizacion.co_cli = self.cliente_id
    cotizacion.co_ven = "07    " # Cambiar por el usuario actual que es el vendedor
    cotizacion.co_tran = '04 '
    cotizacion.forma_pag = '24 '
    cotizacion.tot_bruto = (total - (total * 0.12))
    cotizacion.tot_neto = total
    cotizacion.glob_desc = 0
    cotizacion.tot_reca = 0
    cotizacion.tot_flete = 0
    cotizacion.iva = (total * 0.12)
    cotizacion.feccom = Time.now
    cotizacion.tasa = 1.0
    cotizacion.moneda = 'BSF '
    cotizacion.tasag = 12.0
    cotizacion.tasag10 = 12.0
    cotizacion.tasag20 = 0
    cotizacion.co_us_in = '002 '
    cotizacion.fe_us_in = Time.now
    cotizacion.co_us_mo = ' '
    cotizacion.fe_us_mo = Time.now
    cotizacion.co_us_el = ' '
    cotizacion.fe_us_el = Time.now
    cotizacion.revisado = ' '
    cotizacion.trasnfe = ' '
    cotizacion.co_sucu = '01 '
    cotizacion.otros1 = 0
    cotizacion.rowguid = Profit::CotizC.find_by_sql('Select NEWID() as rowid').collect(&:rowid)[0]

    cotizacion.nombre = ' '
    cotizacion.rif = ' '
    cotizacion.nit = ' '
    cotizacion.comentario = ' '
    cotizacion.dir_ent = self.instalacion
    cotizacion.porc_gdesc = ' '
    cotizacion.porc_reca = ' '
    cotizacion.cta_contab = ' '
    cotizacion.campo1 = ' '
    cotizacion.campo2 = ' '
    cotizacion.campo3 = ' '
    cotizacion.campo4 = ' '
    cotizacion.campo5 = ' '
    cotizacion.campo6 = ' '
    cotizacion.campo7 = ' '
    cotizacion.campo8 = ' '
    cotizacion.aux02 = ' '
    cotizacion.salestax = ' '
    cotizacion.salestax = ' '
    cotizacion.origen = ' '
    cotizacion.origen_d = ' '
    cotizacion.telefono = ' '
    cotizacion.sta_prod = ' '

    cotizacion.save

# Detalle
# INSERT INTO reng_cac (fact_num,reng_num,co_art,co_alma,total_art,stotal_art,pendiente,uni_venta,prec_vta,porc_desc,tipo_imp,reng_neto,cos_pro_un,ult_cos_un,ult_cos_om,cos_pro_om,total_dev,cant_imp,comentario,total_uni,nro_lote,fec_lote) VALUES (25,1,'SG1210VS ','01 ',1.00000,.00000,1.00000,'UND ',3988.84000,'0.00+0.00+0.00 ','1',3988.84,1794.98000,1794.98000,.00000,.00000,.00000,.00000,' ',1.00000,' ','20130226 00:00:00.000')
# INSERT INTO reng_cac (fact_num,reng_num,co_art,co_alma,total_art,stotal_art,pendiente,uni_venta,prec_vta,porc_desc,tipo_imp,reng_neto,cos_pro_un,ult_cos_un,ult_cos_om,cos_pro_om,total_dev,cant_imp,comentario,total_uni,nro_lote,fec_lote) VALUES (25,2,'SG-2002G ','01 ',1.00000,.00000,1.00000,'UND ',250.00000,'0.00+0.00+0.00 ','1',250.00,64.24000,64.24000,.00000,.00000,.00000,.00000,' ',1.00000,' ','20130226 00:00:00.000')

    detalle_presupuesto.each_with_index do |art, index|
      if art.art
        # 25
        # 1
        # 'SG1210VS '
        # '01 '
        # 1.00000
        # .00000
        # 1.00000
        # 'UND '
        # 3988.84000
        # '0.00+0.00+0.00 '
        # '1'
        # 3988.84
        # 1794.98000
        # 1794.98000
        # .00000
        # .00000
        # .00000
        # .00000
        # ' '
        # 1.00000
        # ' '
        # '20130226 00:00:00.000'
        new_art = Profit::RengCac.new

        new_art.fact_num = par_emp.cotc_num + 1
        new_art.reng_num = index + 1
        new_art.co_art = art.codigo
        new_art.co_alma = '01 '
        new_art.total_art = art.cantidad
        new_art.stotal_art = 0.0
        new_art.pendiente = art.cantidad
        new_art.uni_venta = art.art.uni_venta
        new_art.prec_vta = art.art.prec_vta5
        new_art.porc_desc = 0.0
        new_art.tipo_imp = '1'
        new_art.reng_neto = art.art.prec_vta5
        new_art.cos_pro_un = art.art.cos_pro_un
        new_art.ult_cos_un = art.art.cos_pro_un
        new_art.ult_cos_om = 0.0
        new_art.cos_pro_om = 0.0
        new_art.total_dev = 0.0
        new_art.cant_imp = 0.0
        new_art.comentario = ' '
        new_art.total_uni = art.cantidad
        new_art.nro_lote = ' '
        new_art.fec_lote = Time.now.to_s
        new_art.rowguid = Profit::RengCac.find_by_sql('Select NEWID() as rowid').collect(&:rowid)[0]

        new_art.tipo_doc = ' '
        new_art.tipo_doc2 = ' '
        new_art.des_art = ' '
        new_art.co_alma2 = ' '
        # new_art.aux2 = ' '

        new_art.save
        # cotizacion.reng_cac << new_art

      end

    end

    # cotizacion.save

    par_emp.cotc_num += 1
    par_emp.save

  end


end