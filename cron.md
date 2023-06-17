クーロン実行コマンド


docker compose exec web bundle exec whenever --update-crontab

docker compose exec web service cron start  

docker compose exec web service cron status

docker compose exec -it web crontab -l