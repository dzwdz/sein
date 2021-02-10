# frozen_string_literal: true

require_relative "seinfeld/version"
require_relative "seinfeld/data"
require 'date'

module Seinfeld
  class Error < StandardError; end

  class Views
    def self.compact
      data = Data.instance
      for goal in data.goals
        if data.was_marked?(goal, Date.today)
          print "*\e[32m" # todo use some ANSI lib
        end
        print "#{goal} #{data.count_streak(goal)}"
        print "\e[0m\t"
      end
    end
  end

  class CLI
    def self.start
      case ARGV[0]
      when "compact"
        Views.compact
      else
        usage
      end
    end

    def self.usage
      puts "TODO"
    end
  end
end
