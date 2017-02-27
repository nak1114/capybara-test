#ruby
# -*- encoding: utf-8 -*-

require 'capybara/poltergeist'

#Capybara.default_selector = :xpath
Capybara.default_max_wait_time = 5 #sec
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false, timeout: 5000,inspector: 'chrome' })
  #{phantomjs_logger: Logger.new('/dev/null')}
  #{inspector: true}
end

session = Capybara::Session.new(:poltergeist)

session.driver.headers = {
    'User-Agent' => "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.3; WOW64; Trident/7.0; Touch; .NET4.0E; .NET4.0C; .NET CLR 3.5.30729; .NET CLR 2.0.50727; .NET CLR 3.0.30729; Tablet PC 2.0)"
}
session.visit "https://nak1114.github.io/capybara-test/"
session.save_screenshot('screenshot.png', full: true)
session.within_frame('naiyou') do
	print session.html
end
session.within_frame('menu') do
	session.click_link '遷移'
end
session.save_screenshot('screenshot2.png', full: true)
session.within_frame('naiyou') do
	print session.html
  session.find("select > option[value='3']").select_option
  session.find("input[value='3']").set(true)
  session.find("button").click
end
session.save_screenshot('screenshot3.png', full: true)

__END__
取得対象              CSS3              XPath
全ての要素            *                 //*
全てのP要素           p                 //p
全ての子要素          p > *             //p/*
ID指定                #foo              //*[@id='foo']
クラス指定            .foo              //*[contains(@class,'foo')] ※
属性指定              *[title]          //*[@title]
全てのPの最初の子要素 p > *:first-child //p/*[0]
2番目のP要素          p:nth-of-type(2)  //p[2]
子要素Aを持つ全てのP  不可              //p[a]
次の要素              p + *             //p/following-sibling::*[0]

session.driver.debug #デバッグ用
#https://www.qt.io/download-open-source/#section-6
#http://phantomjs.org/download.html
#https://www.chromium.org/getting-involved/download-chromium

Capybara.register_driver :trifleJS do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs: 'TrifleJS.exe', phantomjs_options: ['--emulate:IE8'])
end

Capybara.app_host = 'http://www.google.com'

session = Capybara::Session.new(:trifleJS)

session.visit '/'

session.save_screenshot 'hello_google.png'
