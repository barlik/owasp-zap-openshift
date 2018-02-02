from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.common.keys import Keys

# driver = webdriver.Remote(
#    command_executor='http://127.0.0.1:4444/wd/hub',
#    desired_capabilities=DesiredCapabilities.CHROME)
#

# PROXY = "localhost:9090"
#
# webdriver.DesiredCapabilities.CHROME['proxy'] = {
#     "httpProxy":PROXY,
#     "ftpProxy":PROXY,
#     "sslProxy":PROXY,
#     "noProxy":None,
#     "proxyType":"MANUAL",
#     "class":"org.openqa.selenium.Proxy",
#     "autodetect":False
# }
#
url = 'http://selenium-hub-tuesday3001.52.56.167.35.nip.io/wd/hub'
# url = 'http://selenium-node-chrome-tuesday3001.52.56.167.35.nip.io/wd/hub'

# url = 'http://localhost:4444/wd/hub'

driver = webdriver.Remote(command_executor=url,
                          desired_capabilities=webdriver.DesiredCapabilities.CHROME)


driver.get('http://google.com')
driver.quit()


# driver.get("http://www.python.org")
# assert "Python" in driver.title
# elem = driver.find_element_by_name("q")
# elem.clear()
# elem.send_keys("pycon")
# elem.send_keys(Keys.RETURN)
# assert "No results found." not in driver.page_source
# driver.close()
