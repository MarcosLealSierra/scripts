<#
.SYNOPSIS
  Monitor de proceso de Winflector y MNProgram

.DESCRIPTION
  Monitoriza el proceso de MNProgram con la finalizad de reiniciarlo en caso
  de no estar en marcha con un argumento específico. 

.NOTES
  Version:        1.0
  Author:         Marcos Leal SIerra
  Creation Date:  13/08/2018
#>


$wfistatus = (Get-Service WFIService).Status


Function checkwfi{
  Param()
   
  Process{
    Try{
        if ($wfistatus -eq 'Stopped'){
            $gui = Get-Process wfserver -ErrorAction SilentlyContinue
            if ($gui){
                $gui | Stop-Process -Force
                Stop-Service WFManager
                Stop-Service WFIService
                Start-Service WFIService
            }   
            & C:\winflector\server\wfserver.exe /BATCH
        }
        elseif ($wfistatus -eq 'Running'){
            Break
        }
    }
    
    Catch{
      Break
    }
  }

}


checkwfi
