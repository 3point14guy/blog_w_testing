module ArticlesHelper
  #get only those comments that are in the db
  def persisted_comments(comments)
    comments.reject{ |comment| comment.new_record? }
  end
end
