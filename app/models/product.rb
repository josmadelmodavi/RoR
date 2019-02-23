class Product < ApplicationRecord
	validates :name, presence: true
	validates :quantity, presence: true
	#validates_presence_of :name, :quantity

	def has_nil_fields
		self.name.nil? || self.quantity.nil?
	end
end
