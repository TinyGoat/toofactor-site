# encoding: UTF-8

module ApplicationHelper
  
  def number_to_dollars_or_cents(dollars, options={})
    if dollars < 1
      if dollars < 0.01
        cents = number_with_precision(dollars * 100, options).gsub(/0+$/,'')
        "#{cents}¢"
      else
        "#{(dollars * 100).to_i}¢"
      end
    else
      number_to_currency(dollars,options)
    end
  end
  
end
