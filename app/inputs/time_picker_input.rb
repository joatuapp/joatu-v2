class TimePickerInput < DatePickerInput
  private

  def display_pattern
    I18n.t('components.timepicker.formats.display', default: '%R')
  end

  def picker_pattern
    I18n.t('components.timepicker.formats.picker', default: 'HH:mm')
  end

  def date_options
    date_options_base
  end
end
