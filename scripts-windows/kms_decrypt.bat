@if not exist env.tmp call env.bat

gcloud kms decrypt ^
--location=global ^
--keyring %GCP_KMS_KEYRING% ^
--key=%GCP_KMS_KEYNAME% ^
--ciphertext-file=config.enc ^
--plaintext-file=config.out
