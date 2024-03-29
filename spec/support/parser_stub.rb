require 'pry'
class ParserStub
  DATA = [
    {'/home' => '192.168.10.192' },
    {'/api' => '192.168.0.1' },
    {'/notes' => '192.168.11.5' },
    {'/api' => '192.168.10.193' },
    {'/home' => '192.168.0.1' },
    {'/home' => '192.168.10.192'}
  ]

  def parse
    DATA.each do |line|
      yield(line.keys.first, line.values.first)
    end
  end
end
