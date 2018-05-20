module CommonHelper
  DEFAULT_PAGE_INDEX = 1
  FORMAT_DATE = "%m/%d/%Y"
  FORMAT_DATE_DB = "%Y-%m-%d"
  FORMAT_DATE_FILE = "%m-%d-%Y-%H%M%S"

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

  def get_select_groups has_default = false, has_value_default = false
    groups = Group.select(:id, :name).order("name")

    if has_default
      if has_value_default
        groups = [GroupItem.new(0, t("common.form.all_selection"))] + groups
      else
        groups = [GroupItem.new(nil, t("common.form.choose"))] + groups
      end
    end

    return groups
  end

  def get_select_users has_default = false, has_value_default = false
    users = User.select(:id, :full_name).order("full_name")

    if has_default
      if has_value_default
        users = [User.new(id: 0, full_name: t("common.form.all_selection"))] + users
      else
        users = [User.new(id: nil, full_name: t("common.form.choose"))] + users
      end
    end

    return users
  end

  def create_data_file file_name, file_path, user_id, group_id, type_action_id
    data_file = Array.new
    data_file.push({
       file_name: file_name,
       file_path: file_path,
       user_id: user_id,
       group_id: group_id,
       type_action_id: type_action_id
    })
    DataFile.create(data_file)
  end
end
