$: << File.expand_path("../../lib",__FILE__)
require 'json'
require 'net/http'
require 'logger'

module Cinder
  class Agent

    # load and validate config
    def initialize
      @logger = Logger.new(STDOUT)
      @config = JSON.parse(File.read(File.expand_path("../../config/agent.json",__FILE__)))
      @config_dir = File.expand_path("../../config",__FILE__)
      @logger.info("Getting monitors from config files")
      @monitors = get_all_monitors(@config_dir)

    end


    # launch schedulers
    def start
      begin
      rescue
      end
    end


    # gracefully stop schedulers and quit
    def stop
    end
  end
end
