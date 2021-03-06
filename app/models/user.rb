class User
  include Mongoid::Document
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  # field :sign_in_count,      :type => Integer, :default => 0
  # field :current_sign_in_at, :type => Time
  # field :last_sign_in_at,    :type => Time
  # field :current_sign_in_ip, :type => String
  # field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time
  field :first_name, type: String
  field :last_name,  type: String
  validates_presence_of :first_name, :last_name, message: 'first_last_name_cant_be_blank'

  #this should be deleted when issue #2882 is fixed - https://github.com/plataformatec/devise/pull/2882
  # delete it if authorization will be ok or uncomment lines below otherwise
  # class << self
  #   def serialize_from_session(key, salt)
  #     record = to_adapter.get(key[0]['$oid'])
  #     record if record && record.authenticatable_salt == salt
  #   end
  # end

  has_many :base_objects

  def name
    first_name + ' ' + last_name
  end

  def change_password(current_password, new_password, password_confirmation)
    update_with_password({current_password: current_password, password: new_password, password_confirmation: password_confirmation})
  end

end
