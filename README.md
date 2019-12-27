# Health Checker

Running multiple monitors in parallel to check url availability.

# Running
- `cp config.example.yml config.yml`
- `docker-compose up -d`

# Example config
```yaml
monitors:
  - name: My Blog
    url: https://1devblog.org
    period: "00:00:30"
    notifications:
      - name: Notify Telegram if Down
        state:
          from: up
          to: down
          for: 
        type: telegram
        data:
          message: My Blog is not responding
          token: <TELEGRAM_TOKEN>
          chat_id: <TELEGRAM_CHAT_ID>
      - name: Notify Telegram if Up
        state:
          from: down
          to: up
          for: 
        type: telegram
        data:
          message: My Blog is back online
          token: <TELEGRAM_TOKEN>
          chat_id: <TELEGRAM_CHAT_ID>
```