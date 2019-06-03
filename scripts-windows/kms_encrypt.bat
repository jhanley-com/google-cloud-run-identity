@if not exist env.tmp call env.bat

call gcloud kms encrypt ^
--location=global ^
--keyring %GCP_KMS_KEYRING% ^
--key=%GCP_KMS_KEYNAME% ^
--plaintext-file=config.json ^
--ciphertext-file=config.enc
