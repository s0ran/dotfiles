# Chocolatey Installation for Windows
choco:
	@echo "Installing choco"
	powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

check-choco: choco
	@echo "Checking choco"
	@echo $(PATH)
	@echo $(VPATH)
	@$(CHOCOLATEY_ROOT)/bin/choco -v
	@choco -v