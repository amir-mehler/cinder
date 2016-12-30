#!/usr/bin/env ruby

$: << File.expand_path("../../lib",__FILE__)
require 'trollop'

def stop
  @agent.stop
end

# Trap ^C 
Signal.trap("INT") { 
  stop 
  exit
}

# Trap `Kill `
Signal.trap("TERM") {
  stop
  exit
}

@agent = Cinder::Agent.new
@agent.start
