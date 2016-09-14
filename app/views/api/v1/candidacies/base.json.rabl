attribute :id, :published, :namespace
child :organization, :if => lambda { |candidacy| !candidacy.organization.blank? } do
  extends "api/v1/organizations/base"
end
child :candidates, :if => lambda { |candidacy| !candidacy.candidates.blank? } do
  extends "api/v1/candidates/base"
end
child :candidate_profile do
  attributes :name, :phone, :birthday, :email, :address, :postal_code,
    :biography, :introduction, :twitter, :facebook, :youtube, :wikipedia,
    :website, :cibul, :political_party
end
