class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :latest_message, :last_viewed

  def latest_message
    object.messages.select(:id, :text, :user_id, :created_at).order("created_at").last
  end

  def last_viewed
    hash = object.user_conversations.select(:updated_at).find_by(user_id: instance_options[:user_id])
    hash.updated_at
  end

  # has_many :messages
  # class MessageSerializer < ActiveModel::Serializer
  #   attributes :id, :text, :user_id, :conversation_id, :created_at
  # end

end
