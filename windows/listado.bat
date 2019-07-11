dir C:\Users\* /S /b | findstr /R Desktop | findstr ".doc .docx .xls .xlsx .pdf .exe .p12 .cert .txt .mm .jpg .zip" > C:\%computername%_listadoficheros.txt
