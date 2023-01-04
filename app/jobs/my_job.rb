require 'sidekiq'

class MyJob
  include Sidekiq::Job

  def perform(csv)
    puts 'lala'
  end
end