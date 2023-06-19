# STEP1 劇場を複数館扱えるようにしよう 動作確認の手順
1.映画を予約する

2.Mailtrapで予約メールが届いているかを確認する

3.予約一覧ページで予約があることを確認する




# STEP2 メール通知をできるようにしよう 動作確認の手順

※STEP1とでメール通知を確認する


# STEP3 定時実行をできるようにしよう 動作確認の手順

1.schedule.rbを開き下記の時間を適切な時間に設定する

every 1.day, at: Time.zone.parse('19:00').localtime do
  rake 'remind_reservations:send_reminders'
end

2.以下のコマンドを実行し、クーロンを設定する

docker compose exec web bundle exec whenever --update-crontab

3.クーロンがちゃんと設定されているか確認するために以下のコマンドを実行する

docker compose exec -it web crontab -l

4.設定した時刻になった時にMailtrapを見てメールが届いているかを確認する



# STEP4 人気作品ランキングを集計して掲載しよう 動作確認の手順

1.必要に応じてデータベースからrankingsテーブルのレコードを削除する(date:今日の日付)

2.schedule.rbを開き下記の時間を適切な時間に設定する。

every :day, at: Time.zone.parse('10:51').localtime do
  runner "Ranking.dayly_totalling"
end

3.以下のコマンドを実行し、クーロンを設定する

docker compose exec web bundle exec whenever --update-crontab

4.クーロンがちゃんと設定されているか確認するために以下のコマンドを実行する

docker compose exec -it web crontab -l

5.設定した時刻になった時にトップページでランキングが表示されていることを確認する



# STEP5 自分なりの改善　の動作確認の手順

1.adminユーザーでログインして映画詳細画面→レビューページに遷移する(憧れを超えた侍たち)

2.評価を入力せずに送信を行い、アラートが出ることを確認する

3.評価を入力してアラートが出ずに投稿できることを確認する