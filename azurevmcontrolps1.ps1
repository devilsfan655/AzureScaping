$Computers = Get-AzVM -ResourceGroup $args[0] 

Write-Host "Found the following machine(s) in $($args[0]) `n" -ForegroundColor Yellow

ForEach ($VirtualMachine in $Computers)
{
    Write-Host $VirtualMachine.Name -ForegroundColor DarkYellow
}

Write-Host "`n"
Write-Host "Executing the $($args[1]) command on each machine `n" -ForegroundColor Yellow


ForEach ($VirtualMachine in $Computers){

    if ($args[1] -match 'start'){

        Write-Host "Attempting to start Virtual Machine $($VirtualMachine.Name)" -ForegroundColor DarkYellow

        try 
        {
            Start-AzVM -ResourceGroupName $args[0] -Name $VirtualMachine.Name -Confirm:$false -ErrorAction SilentlyContinue 
            Write-Host "Successfully started $($VirtualMachine.Name)" -ForegroundColor DarkGreen
        }
        catch
        {
            Write-Host "Failed to start $($VirtualMachine.Name)" -ForegroundColor DarkRed
        }

    }
    
    elseif ($args[1] -match 'stop') {

        Write-Host "Attempting to stop Virtual Machine $($VirtualMachine.Name)" -ForegroundColor DarkYellow
        try 
        {
            Stop-AzVM -ResourceGroupName $args[0] -Name $VirtualMachine.Name -Confirm:$false -ErrorAction SilentlyContinue -Force
            Write-Host "Successfully stopped $($VirtualMachine.Name)" -ForegroundColor DarkGreen
        }
        catch 
        {
            Write-Host "Failed to stop $($VirtualMachine.Name)" -ForegroundColor DarkRed
        }


    }
}