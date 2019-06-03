call setup_sa.bat
call setup_kms_keys.bat
call setup_kms.bat
call kms_encrypt.bat
call setup_bucket.bat
call build.bat
del env.tmp
