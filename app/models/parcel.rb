class Parcel < ApplicationRecord
  STATUS = ['Sent', 'In Transit', 'Delivered']
  PAYMENT_MODE = ['COD', 'Prepaid']

  validates :weight, :status, presence: true
  validates :status, inclusion: STATUS
  validates :payment_mode, inclusion: PAYMENT_MODE
  validates :tracking_number, presence: true, uniqueness: true

  belongs_to :service_type
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  before_create :generate_tracking_number
  after_create :send_notification

  private

  def send_notification
    UserMailer.with(parcel: self).status_email.deliver_later
  end

  def generate_tracking_number
    self.tracking_number = SecureRandom.uuid
  end
end
