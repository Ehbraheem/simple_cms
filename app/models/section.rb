class Section < ApplicationRecord

	act_as_list scope: :subject

	belongs_to :page
	has_many :section_edits
	has_many :admin_users, through: :section_edits

	scope :visible,      -> { where(visible: true) }
	scope :invisible,    -> { where(visible: false) }
	scope :sorted,       -> { order("position ASC") }
	scope :newest_first, -> { order("created_at DESC") }

	CONTENT_TYPES = %W(text HTML)

	validates_presence_of :name, :content
	validates_length_of :name, maximum: 255
	validates_inclusion_of :content_type, in: CONTENT_TYPES,
		message: "must be one of: #{CONTENT_TYPES.join(', ')}" 

end
