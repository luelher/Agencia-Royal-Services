class Profit::Cobro < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'cobros'
  # attr_accessible :title, :body

  has_many :reng_cob, {:foreign_key => 'cob_num', :primary_key => 'cob_num', :class_name => "Profit::RengCob"}

  has_one :cliente, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  scope :historial_by_factura, lambda { |fact| joins(:reng_cob => :docum_cc).where("docum_cc.observa like ? AND reng_cob.tp_doc_cob='GIRO' AND docum_cc.tipo_doc='GIRO'","%FACT #{fact}").order("fec_cob DESC") }

  scope :historial_by_cliente, lambda { |cli| joins(:reng_cob => :docum_cc).where("cobros.co_cli = ? and docum_cc.observa like ? AND reng_cob.tp_doc_cob='GIRO' AND docum_cc.tipo_doc='GIRO'",cli,"%FACT %").order("fec_cob DESC") }  

  scope :historial_by_factura_and_giro, lambda { |fact, giro| joins(:reng_cob => :docum_cc).where("docum_cc.observa like ? AND reng_cob.tp_doc_cob='GIRO' AND docum_cc.tipo_doc='GIRO'","%GIRO #{giro}/%FACT #{fact}").order("fec_cob DESC") }  

  def self.historial_by_f(fact)
    cobros = self.historial_by_factura fact
    if cobros.nil?
      nil
    else
      Hash[cobros.map{|x| [x.cob_num, x]}].values
    end
  end

  def self.historial_by_c(cli)
    cobros = self.historial_by_cliente cli
    if cobros.nil?
      nil
    else
      Hash[cobros.map{|x| [x.cob_num, x]}].values
    end
  end

end
