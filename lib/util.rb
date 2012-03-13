class Util
  def self.email_to_proposed_username email
    email[/[^@]*/]
  end
end