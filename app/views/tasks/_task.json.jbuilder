json.extract! task, :id, :deadline_at, :title, :note, :is_done, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
