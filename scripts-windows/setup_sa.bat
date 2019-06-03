@if not exist env.tmp call env.bat

call gcloud iam service-accounts create %GCP_SA_NAME% ^
--display-name=%GCP_SA_NAME%
@if errorlevel 1 goto err_out
@echo on

@goto end

:err_out
@echo *************************************************************
@echo Service Account Setup Failed     Service Account Setup Failed
@echo *************************************************************

:end
