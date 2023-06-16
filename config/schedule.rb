# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数をセット
set :environment, :development
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

# タイムゾーンをJSTに設定
ENV['TZ'] = 'Asia/Tokyo'
Time.zone = 'Tokyo'

ENV.each { |k, v| env(k, v) }

every 1.day, at: Time.zone.parse('19:00').localtime do
  rake 'remind_reservations:send_reminders'
end