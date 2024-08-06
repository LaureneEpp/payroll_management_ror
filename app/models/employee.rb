class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :team, optional: true
  has_many :payslip
  
  has_one :department, through: :team
  belongs_to :position, optional: true
  
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]
  
    before_validation :set_default_values

    def fullname
        "#{first_name.capitalize} #{last_name.capitalize}"
    end
    
    def avatar_thumbnail
        avatar.variant(resize_to_limit: [300,300]).processed
    end
      
    def tbd_team?
        self.team.name == 'TBD'
    end
    
    def tbd_position?
        self.position.name == 'TBD'
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w[first_name last_name]
    end
  
    def self.ransackable_associations(_auth_object = nil)
      %w[avatar_attachment avatar_blob department payslips user position team]
    end
    
    private
    
    def add_default_avatar
        return if self.avatar.attached?
        avatar.attach(
          io:
            File.open(Rails.root.join("app", "assets", "images", "anonymous.jpg")),
          filename: "anonymous.jpg",
          content_type: "image/jpg",
        )
    end
    
      def set_default_values
        self.position ||= Position.find_or_create_by(name: 'TBD')
        self.team ||= Team.find_or_create_by(name: 'TBD')
      end
end
