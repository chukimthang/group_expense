module CommonHelper
  DEFAULT_PAGE_INDEX = 1
  FORMAT_DATE = "%m/%d/%Y"

  def get_select_categories has_default = false
    categories = Category.where(is_deleted: false)

    if has_default
      categories = [GroupItem.new(0, t("common.form.all_selection"))] + categories
    end

    return categories
  end
end
