require 'singleton'
require 'json'
require 'date'

module Seinfeld
  class Data
    include Singleton

    def initialize
      @goals = JSON.parse(File.read("#{Dir.home}/.seinfeld")) # todo error handling
    end

    def goals
      @goals.keys
    end

    def is_a_goal?(goal)
      goals.include?(goal)
    end

    def was_marked?(goal, day)
      @goals[goal]["marks"].include?(day.iso8601)
    end

    def count_streak(goal) # todo this is inefficient
      streak = 0
      if was_marked?(goal, Date.today)
        streak = 1
      end

      last = Date.today - 1
      while was_marked?(goal, last)
        last -= 1
        streak += 1
      end

      streak 
    end
  end
end
