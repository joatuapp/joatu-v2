module ProfilesHelper
  def acceptable_currencies
    {
      t('currencies.trade') => "trade",
      t('currencies.caps') => "caps",
      t('currencies.cash') => "cash",
      t('currencies.cheque') => "cheque",
      t('currencies.bitcoin') => "bitcoin",
    }
  end

  def acceptable_currency_translated(key)
    acceptable_currencies.invert[key]
  end
end
