require 'singleton'
require 'json'
require 'date'

module Sein
  class Data
    include Singleton

    def path
      "#{Dir.home}/.sein"
    end

    def initialize
      @goals = JSON.parse(File.read(path)) rescue {}
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

    def add_goal(name)
      if is_a_goal?(name)
        puts "error: #{name} already exists"
      else
        @goals[name] = {"marks":[]}
        puts "created #{name}"
      end
    end

    def mark(goal, day)
      if not is_a_goal?(goal)
        puts "error: #{goal} isn't a goal"
        return
      end

      if was_marked?(goal, day)
        puts "#{goal} is already marked for #{day.iso8601}"
        return
      end

      @goals[goal]["marks"] << day.iso8601
      puts "\e[32mmarked #{goal} for #{day.iso8601}\e[0m"
    end

    def save
      File.open(path, "w") do |f|
        f.write(@goals.to_json)
        puts "saved!"
      end
    end
  end
end
