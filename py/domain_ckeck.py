import whois
from datetime import date, datetime


def check_domain(domain):
	try:
		w = whois.whois(domain)
		expiry_date = w.expiration_date
		print(f"Domain: {domain}, Expiry: {expiry_date}")
		return expiry_date
	except Exception as e:
		print(f"Error fetching {domain}: {e}")
		return None


def monitor_domain_with_tlds(base_name, tlds, interval=3600):
	domains_to_check = [f"{base_name}.{tld}" for tld in tlds]

	#while True:
	for domain in domains_to_check:
		expiry = check_domain(domain)
		try:
			if expiry is None or expiry < datetime.today():
				print(f"Domain {domain} might now be available!")
		except Exception as e:
			print(f"Error comparing times {domain}: {e}")
	#print(f"Completed one check cycle. Waiting for {interval} seconds.")
	#time.sleep(interval)


tlds = [
	"net", "io", "ai", "dev",
	"tech", "app", "eu", "ee"
]

monitor_domain_with_tlds(base_name="DOMAIN_NAME", tlds=tlds, interval=86400)

