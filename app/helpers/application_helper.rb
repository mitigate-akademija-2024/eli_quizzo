# app/helpers/application_helper.rb
module ApplicationHelper
    def btn_class
      'inline-block rounded border border-pink-600 bg-pink-600 px-12 py-3 text-sm font-medium text-white hover:bg-transparent hover:text-pink-600 focus:outline-none focus:ring active:text-pink-500'
    end
  
    def btn_class_small
      'inline-block rounded border border-pink-600 bg-pink-600 px-4 py-2 text-xs font-medium text-white hover:bg-transparent hover:text-pink-600 focus:outline-none focus:ring active:text-pink-500'
    end

    def format_date(date)
      date.strftime('%F')
    end
  end
