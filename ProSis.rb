require 'socket'
require 'uri'

require_relative 'handle_request'

class Proxy
  def run port
    begin
      @socket = TCPServer.new port

      loop do
        s = @socket.accept
        Thread.new s, &method(:handle_request)
      end
      # CTRL-C
    rescue Interrupt #
      puts 'Got Interrupt..'
      # S'assure de diriger le socket vers erreur
    ensure
      if @socket
        @socket.close
        puts 'Socked closed..'
      end
      puts 'Quitting.'
    end
  end
end

# Get parameters and start the server
if ARGV.empty?
  port = 8008
elsif ARGV.size == 1
  port = ARGV[0].to_i
else
  puts 'Usage: proxy.rb [port]'
  exit 1
end

Proxy.new.run port
