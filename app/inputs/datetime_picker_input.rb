class DatetimePickerInput < DatePickerInput
  private

  def display_pattern
    I18n.t('components.datepicker.formats.display', default: '%d/%m/%Y') + ' ' +
        I18n.t('components.timepicker.formats.display', default: '%R')
  end

  def picker_pattern
    I18n.t('components.datepicker.formats.picker', default: 'DD/MM/YYYY') + ' ' +
        I18n.t('components.timepicker.formats.picker', default: 'HH:mm')
  end
end
