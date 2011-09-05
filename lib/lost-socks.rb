module LostSocks

  VERSION = "0.0.1"

  def self.delay=(seconds)
    Verifier.delay = seconds
  end
  
  def self.verify(domain)
    Verifier.new(domain)
  end
    
  class Verifier
    
    @@delay = nil
    
    def self.delay=(seconds)
      @@delay = seconds
    end
    
    def initialize(domain)
      @server = nil
      @domain = domain
      yield self if block_given?
      self
    end
    
    def with_server(server)
      @server = server
      yield self if block_given?
      self
    end
    
    def resolves_to(ip)
      check! 'A', ip
    end
    
    def is_aliased_to(domain)
      check! 'CNAME', domain
    end
    
    def maps_mail_to(domain, args = {})
      check! 'MX', domain, args
    end
    
    # or it.answers_to ??
    def has_authorative_nameserver_of(domain)
      check! 'NS', domain
    end
    
  private
  
    def check!(query, against, args = {})
      if ['A', 'CNAME', 'NS'].include?(query)
        pattern = /#{@domain}\.\s+\d+\s+IN\s+#{query}\s+#{against}/
      elsif query == 'MX'
        pattern = /#{@domain}\.\s+\d+\s+IN\s+MX\s+#{args[:priority]}\s+#{against}/
      else
        raise "Unsupported query (#{query.inspect}): only A, CNAME and MX."
      end      
      send(result!(query) =~ pattern ? :pass! : :fail!, query, against, args)
    end
    
    def result!(query)
      @last_dig_command = if @server
        "dig @#{@server} #{@domain} #{query}"
      else
        "dig #{@domain} #{query}"
      end
      sleep(@@delay) if @@delay
      @last_dig_output = `#{@last_dig_command}`
    end
    
    def pass!(*args)      
      report! 'PASS', *args
    end
    
    def fail!(*args)
      report! 'FAIL', *args
      puts @last_dig_command
      puts @last_dig_output
    end
    
    def report!(result, query, against, args = {})
      puts "#{result}: #{@domain} #{query} #{against} #{"@#{@server}" if @server} #{args.inspect if args.any?}"
    end
  end

end
