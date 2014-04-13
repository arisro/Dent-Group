# config/initializers/time_formats.rb
Time::DATE_FORMATS[:date] = "%d/%m/%Y"
Time::DATE_FORMATS[:news] = lambda { |time| time.strftime("%B %d, %Y") }