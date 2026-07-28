class Bus < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :bookings,dependent: :destroy
  scope :bus_for_admin, ->(current_user) { where(user_id: current_user.id) }


  validates :bus_name, presence: true
  validates :bus_number, presence: true, format: { with:  /\A[A-Z]{2}-\d{2}-[A-Z]{2}-\d{4}\z/, message: "bus number must in these format MP-09-FA-1234" }
  validates :total_seat,presence: true, numericality: { greater_than_or_equal_to: 45, less_than_or_equal_to: 55,  message: "must be between 45 and 55" }
  validate :source_and_destination_diff
  validates :source,presence: true
  validates :destination,presence: true
  validate :arrival_time_must_greater_to_departure_time
  validates :arrival_at, presence: true
  validates :departure_at, presence: true
  validates :images, presence: true, limit: { min: 5, message: "must contain  5 image files" }
  after_save :set_availabel_seat
  before_save :capitalize_source_and_destination
   validate :correct_image_type

  private
  def source_and_destination_diff
    if source == destination
      errors.add(:destination, "source and destination must be different")
    end
  end

  def arrival_time_must_greater_to_departure_time
    if arrival_at < departure_at
      errors.add(:arrival_at, "arrival must greater than departure")
    end
  end
  def set_availabel_seat
    self.available_seat = self.total_seat
  end
  
  
   def correct_image_type
    
        images.each do |img|
        
        unless img.content_type.in?(%w(image/jpeg image/png image/jpg))
          errors.add(:images, "Must be a JPG, JPEG or PNG")
        end
      end
    end
    def correct_image_size
    
       images.each do |img|
        if img.byte_size > 5.megabytes
          errors.add(:images, "is too large (maximum size is 5MB)")
        end
     
        end
     end

     def capitalize_source_and_destination
     
     end

 
end
