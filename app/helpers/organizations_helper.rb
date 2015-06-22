module OrganizationsHelper
  def org_visibility_options(org)
    if org.is_hub?
      {t('offers.visibility.global') => "global", t('offers.visibility.org') => "organization", t('offers.visibility.pod', pod_name: org.pod.name) => "pod"}
    else
      {t('offers.visibility.global') => "global", t('offers.visibility.org') => "organization"}
    end
  end
end
