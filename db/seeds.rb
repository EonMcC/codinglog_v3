require_relative('../models/language.rb')
require_relative('../models/timer.rb')

Language.delete_all()
Timer.delete_all()


language_ruby = Language.new({"name" => "Ruby", "log_time" => 1 })
language_css = Language.new({"name" => "CSS", "log_time" => 5 })

timer = Timer.new({"started" => false})

language_ruby.save()
language_css.save()
timer.save()
