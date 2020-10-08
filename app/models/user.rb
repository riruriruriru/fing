class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:timeoutable

  enum rolesdevise: [:indef,:admin, :tutor, :coordinador, :supervisor]
  after_initialize :set_default_role, :if => :new_record?

  has_many :annotation , dependent: :delete_all
  has_many :studentannotations
  belongs_to  :role
  belongs_to :department

  def set_default_role
    self.rolesdevise ||= :indef

  end

  def name; "#{firstname} #{lastname}";end
  def nameandrole; "#{firstname} #{lastname} (#{role.name}) ";end
  
    
  

end
