class RemoveHasYoutubeUrlFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :has_youtube_link, :boolean
    remove_column :reviews, :other_video_url, :string
  end
end
