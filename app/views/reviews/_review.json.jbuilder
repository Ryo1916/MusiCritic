json.extract! review, :id, :title, :rating, :text, :user_id, :created_at, :updated_at
json.url review_url(review, format: :json)
