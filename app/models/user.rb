class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :async, :confirmable

  validate :email_is_unique, on: :create
  validate :subdomain_is_unique, on: :create
  after_validation :create_tenant
  after_create :create_account
  after_create :add_role_to_user

  # def confirmation_required?
  # 	false
  # end

  private
  	# email should be unique in Account model
  	def email_is_unique
  		# do not validate email if errors are already present.
  		return false unless self.errors[:email].empty?

  		unless Account.find_by_email(email).nil?
  			errors.add(:email, " is already used")
  		end
  	end

    # Subdomains should be unique
    def subdomain_is_unique
      if subdomain.present?
        unless Account.find_by_subdomain(subdomain).nil?
          errors.add(:subdomain, "is already used")
        end

        if Apartment::Elevators::Subdomain.excluded_subdomains.include?(subdomain)
          errors.add(:subdomain, "is not a valid subdomain.")
        end
      end
    end

  	def create_account
  		account = Account.new(:email => email, :subdomain => subdomain)
  		account.save!
  	end

    def create_tenant
      return false unless self.errors.empty?

      # If its a new record, create the tenant
      # For edits, do not create
      if self.new_record?
        Apartment::Tenant.create(subdomain)
      end
      # Change schema to the tenant
      Apartment::Tenant.switch!(subdomain)
    end

    # Add default role to the user who signs up
    def add_role_to_user
      if created_by_invite?
        add_role :app_user
      else
        add_role :app_admin
      end
    end

end
