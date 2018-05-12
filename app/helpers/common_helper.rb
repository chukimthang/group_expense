module CommonHelper
  DEFAULT_PAGE_INDEX = 1
  FORMAT_DATE = "%m/%d/%Y"
  FORMAT_DATE_DB = "%Y-%m-%d"

  # convert string to datetime
  def to_date(str_date)
    unless str_date.blank?
      return Date.strptime(str_date, FORMAT_DATE)
    end
    
    return nil
  end

  def get_select_categories has_default = false, has_value_default = false
    categories = Category.select(:id, :name).order("name")

    if has_default
      if has_value_default
        categories = [GroupItem.new(0, t("common.form.all_selection"))] + categories
      else
        categories = [GroupItem.new(nil, t("common.form.choose"))] + categories
      end
    end

    return categories
  end
end
