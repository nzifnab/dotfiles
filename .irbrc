#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

# print SQL to STDOUT in rails console
if (defined?(Rails) && Rails.respond_to?(:env) && Rails.env) || ENV.include?('RAILS_ENV') #ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
	load File.dirname(__FILE__) + "/.railsrc"
end

class Object
	# list methods which aren't in superclass
	def local_methods(obj = self)
		(obj.methods - obj.class.superclass.instance_methods).sort
	end

	def self.local_methods
		(self.methods - self.superclass.methods).sort
	end
end

def copy(str)
	IO.popen('pbcopy', 'w') { |f| f << str.to_s }
	str.to_s
end

def paste
	`pbpaste`
end

def uf(email='nbenes@servenow.com')
	User.find_by_email(email)
end

# Gives sgcore console immediate access to run the subscriptions update actions using
# the method "service_queue"
if ENV.include?("RAILS_ENV") && ENV["PWD"] =~ /sgcore$/
  module BackgrounDRb

    class MetaWorker
      def self.set_worker_name(*args)
      end

      def logger
        return LogThis.new
      end
    end

    class LogThis
      def info(val)
        puts val
      end
    end
  end

  require "#{ENV["PWD"]}/lib/workers/subscription_queue_worker.rb"

  def service_queue
    SubscriptionQueueWorker.new.service_queue
  end
end

# Gives servemanager console direct access to the sgcore development database
=begin
if ENV.include?('RAILS_ENV') && ENV["PWD"] =~ /servemanager$/
	require 'active_record'
	DUP_CONNECTION = {
			"sgcore_development" => {
			"adapter"   => "postgresql",
			"database"  => "sgcore",
			"username"  => "sgcore",
			"password"  => "please$$",
			"host"      => "127.0.0.1"
		},
		"sgcore_staging" => {
			"adapter"   => "postgresql",
			"database"  => "sgcore_stage",
			"username"  => "sgcore_stage",
			"password"  => "letMeIn",
			"host"      => "127.0.0.1"
		},
		"sgcore_production" => {
			"adapter"   => "postgresql",
			"database"  => "sgcore",
			"username"  => "sgcore",
			"password"  => "please$$",
			"host"      => "10.0.8.50"
		}
	}

	module SG
		class User < ::ActiveRecord::Base
			establish_connection(DUP_CONNECTION['sgcore_' + ENV['RAILS_ENV']])
		end

		class Entity < ::ActiveRecord::Base
			establish_connection(DUP_CONNECTION['sgcore_' + ENV['RAILS_ENV']])
		end

		class Profile < ::ActiveRecord::Base
			establish_connection(DUP_CONNECTION['sgcore_' + ENV['RAILS_ENV']])
		end

		class Site < ::ActiveRecord::Base
			establish_connection(DUP_CONNECTION['sgcore_' + ENV['RAILS_ENV']])
		end
	end
end
=end
