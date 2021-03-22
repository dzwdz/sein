# frozen_string_literal: true

require_relative "sein/version"
require_relative "sein/data"
require 'date'

module Sein
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
        if data.was_marked?(goal, Sein.today)
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
      case ARGV
      in ["new", *goals] unless goals.empty?
        goals.each do |name|
          Data.instance.add_goal(name)
        end
        Data.instance.save

      in ["compact", *goals]
        Views.compact(ARGV.drop(1))

      in ["mark", *goals] unless goals.empty?
        goals.each do |goal|
          Data.instance.mark(goal, Sein.today)
        end
        Data.instance.save

      else
        usage
      end
    end

    def self.usage
      puts "TODO"
    end
  end
end
