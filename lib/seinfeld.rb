# frozen_string_literal: true

require_relative "seinfeld/version"
require_relative "seinfeld/data"
require 'date'

module Seinfeld
  class Error < StandardError; end
  
  # the midnight is switched to 5 AM, because i often mark stuff after midnight
  # just a minor QoL tweak to avoid having to specify the date
  # (and to avoid implementing it yet, i'm lazy)
  def self.today
    (Time.now - 60 * 60 * 5).to_date
  end

  class Views
    def self.compact(goals)
      data = Data.instance
      if goals.empty?
        goals = data.goals
      end

      for goal in goals
        if data.was_marked?(goal, Seinfeld.today)
          print "*\e[32m" # todo use some ANSI lib
        end
        print "#{goal} #{data.count_streak(goal)}"
        print "\e[0m\t"
      end

      print "\n"
    end
  end

  class CLI
    def self.start
      case ARGV[0]
      when "compact"
        Views.compact(ARGV.drop(1))
      when "mark"
        if ARGV.length < 2
          usage
        else
          for goal in ARGV.drop(1)
            Data.instance.mark(goal, Seinfeld.today)
          end
          Data.instance.save
        end
      else
        usage
      end
    end

    def self.usage
      puts "TODO"
    end
  end
end
