# Obtener módulos de memoria instalados
Get-WmiObject win32_physicalmemory | Format-Table Manufacturer,Banklabel,Configuredclockspeed,Devicelocator,Capacity,Serialnumber -autosize

# Obtener placa base
Get-WmiObject Win32_BaseBoard
