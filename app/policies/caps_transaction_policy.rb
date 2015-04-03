class CapsTransactionPolicy < ApplicationPolicy

  def create?
    if record.source == CapsGenerator.instance
      # A caps transaction whose source is the CapsGenerator is
      # creating brand new Caps. As such, only Admins should be allowed to
      # do this:
      user.is_admin?
    else
      # Otherwise, users can only spend their own caps:
      user == record.source
    end

    # TODO: Need to add a case where an organization's admins
    # can spend the org's caps, once I set up org admins.
  end
end
