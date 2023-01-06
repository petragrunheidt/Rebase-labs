require 'selenium-webdriver'

driver = Seleniun::WebDriver.for :chrome
driver.navigate.to 'http://google.com'

element = driver.find_element(name: 'q')
element.send_keys "hello WebDriver!"
element.submit

puts driver.title

driver.quit