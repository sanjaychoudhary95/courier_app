class Parcel < ApplicationRecord
  STATUS = ['Sent', 'In Transit', 'Delivered']
  PAYMENT_MODE = ['COD', 'Prepaid']

  before_validation :generate_tracking_number

  validates :weight, :status, presence: true
  validates :status, inclusion: STATUS
  validates :payment_mode, inclusion: PAYMENT_MODE
  validates :tracking_number, presence: true, uniqueness: true

  belongs_to :service_type
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  after_create :send_notification
  after_update :send_status_emails, if: :saved_change_to_status?

  private

  def send_notification
    UserMailer.with(parcel: self).status_email.deliver_later
  end

  def send_status_emails
    UserMailer.with(parcel: self).status_update_email.deliver_later
  end

  def generate_tracking_number
    loop do
      self.tracking_number = SecureRandom.hex(14) # Generate a random tracking number
      break unless Parcel.exists?(tracking_number: self.tracking_number)
    end
  end
end
