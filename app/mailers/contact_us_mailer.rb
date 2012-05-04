# -*- coding: utf-8 -*-
class ContactUsMailer < ActionMailer::Base

  def contact(message)
    to_address = case
                   when :support
                     'support@toofactor.com'
                   when :billing
                     'billing@toofactor.com'
                   else
                     'contact@toofactor.com'
                 end
    mail to: to_address,
         from: message[:from],
         subject: "[☁] #{message[:subject] || '(No Subject Given)'}",
         body: message[:body]
  end

end
