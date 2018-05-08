# :nodoc:
module ApplicationHelper
  def left_menu
    left_menu_entries(left_menu_content)
  end

  private

  def selected_locale
    locale = FastGettext.locale
    locale_list.detect {|entry| entry[:locale] == locale}
  end

  def locale_list
    [
      {
        flag: 'us',
        locale: 'en',
        name: 'English (US)',
        alt_name: 'United States'
      },
      {
        flag: 'fr',
        locale: 'fr',
        name: 'Français',
        alt_name: 'France'
      },
      {
        flag: 'es',
        locale: 'es',
        name: 'Español',
        alt_name: 'Spanish'
      },
      {
        flag: 'de',
        locale: 'de',
        name: 'Deutsch',
        alt_name: 'German'
      },
      {
        flag: 'jp',
        locale: 'ja',
        name: '日本語',
        alt_name: 'Japan'
      },
      {
        flag: 'cn',
        locale: 'zh',
        name: '中文',
        alt_name: 'China'
      },
      {
        flag: 'it',
        locale: 'it',
        name: 'Italiano',
        alt_name: 'Italy'
      },
      {
        flag: 'pt',
        locale: 'pt',
        name: 'Portugal',
        alt_name: 'Portugal'
      },
      {
        flag: 'ru',
        locale: 'ru',
        name: 'Русский язык',
        alt_name: 'Russia'
      },
      {
        flag: 'kr',
        locale: 'kr',
        name: '한국어',
        alt_name: 'Korea'
      },
    ]
  end

  def left_menu_entries(entries = [])
    output = ''
    entries.each do |entry|
      children_selected = entry[:children] &&
        entry[:children].any? {|child| current_page?(child[:href]) }
      entry_selected =  current_page?(entry[:href])
      li_class =
      case
        when children_selected
          'open'
        when entry_selected
          'active'
      end
      output +=
        content_tag(:li, class: li_class) do
          subentry = ''
          subentry +=
            link_to entry[:href], title: entry[:title], class: entry[:class], target: entry[:target] do
              link_text = ''
              link_text += entry[:content].html_safe
              if entry[:children]
                if children_selected
                  link_text += '<b class="collapse-sign"><em class="fa fa-minus-square-o"></em></b>'
                else
                  link_text += '<b class="collapse-sign"><em class="fa fa-plus-square-o"></em></b>'
                end
              end

              link_text.html_safe
            end
          if entry[:children]
            if children_selected
              ul_style = 'display: block'
            else
              ul_style = ''
            end
            subentry +=
              "<ul style='#{ul_style}'>" +
                left_menu_entries(entry[:children]) +
                "</ul>"
          end

          subentry.html_safe
        end
    end
    output.html_safe
  end

  def left_menu_content
    sidebar_menus = [
      {
        href: root_path,
        title: _('dashboard'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('Dashboard') + "</span>",
      }
    ]

    # administration menus
    administration_children = Array.new

    administration_children.push({
      href: users_path,
      title: _("#{t('model.user.controller_name')}"),
      content: "<i class='fa fa-user'></i> <span class='menu-item-parent'>" + _("#{t('model.user.controller_name')}") + "</span>",
      controller: 'users'
    })

    administration_menus = Array.new
    administration_menus.push({
      href: "#",
      title: _("#{t('common.menu.administration')}"),
      content: "<i class='fa fa-cogs fa-lg'></i> <span class='menu-item-parent'>" + _("#{t('common.menu.administration')}") + "</span>",
      children: administration_children
    })
    sidebar_menus = sidebar_menus | administration_menus

    unless params[:group_id].nil?
      # group member

      member_children = Array.new
      member_children.push({
        href: group_group_members_path,
        title: _("#{t('model.group_member.title.add')}"),
        content: "<i class='fa fa-plus-square'></i> <span class='menu-item-parent'>" + _("#{t('model.group_member.title.add')}") + "</span>",
        controller: 'group_members'
      })

      member_menus = Array.new
      member_menus.push({
        href: "#",
        title: _("#{t('model.group_member.controller_name')}"),
        content: "<i class='glyphicon glyphicon-user'></i> <span class='menu-item-parent'>" + _("#{t('model.group_member.controller_name')}") + "</span>",
        children: member_children
      })

      sidebar_menus = sidebar_menus | member_menus

      # utility menus

      utility_children = Array.new
      utility_children.push({
        href: group_categories_path,
        title: _("#{t('model.category.controller_name')}"),
        content: "<i class='fa fa-tasks'></i> <span class='menu-item-parent'>" + _("#{t('model.category.controller_name')}") + "</span>",
        controller: 'categories'
      })

      utility_children.push({
        href: group_products_path,
        title: _("#{t('model.product.controller_name')}"),
        content: "<i class='fa fa-product-hunt'></i> <span class='menu-item-parent'>" + _("#{t('model.product.controller_name')}") + "</span>",
        controller: 'products'
      })

      utility_menus = Array.new
      utility_menus.push({
        href: "#",
        title: _("#{t('common.menu.utility')}"),
        content: "<i class='fa fa-table'></i> <span class='menu-item-parent'>" + _("#{t('common.menu.utility')}") + "</span>",
        children: utility_children
      })

      sidebar_menus = sidebar_menus | utility_menus
    end

    sidebar_menus
  end
end
