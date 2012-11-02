require 'benchmark'

exp = Cobranza::Experiencia.new
exp.desde = Time.now
Benchmark.bmbm do |r|
  r.report "Calculando Experiencias" do
    exp.calcular_experiencias
 end
end