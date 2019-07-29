class Token < ApplicationRecord
  belongs_to :user
  before_create :generate_token
  validates :user_id, presence:true
  def is_valid?
    DateTime.now < self.expires_at
  end
  private
  def generate_token
    begin
      self.token = SecureRandom.hex(20)
    end while Token.where(token: self.token).any?
    self.expires_at ||= 1.month.from_now
  end
end