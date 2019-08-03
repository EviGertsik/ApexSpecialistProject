trigger MaintenanceRequest on Case (before update, after update) 
{
    
    Map<Id, Case> applicableCases = new Map<Id, Case>();
    if(Trigger.isUpdate)
    {
        if(Trigger.isAfter)
        {
            for(Case a: Trigger.new)
            {
                if(a.isClosed && (a.Type.equals('Repair') || a.type.equals ('Routine Maintenance')))
                {
                    applicableCases.put(a.Id, a);
                }
            }
            // call MaintenanceRequestHelper.updateWorkOrders
            MaintenanceRequestHelper.updateWorkOrders(applicableCases);
        }
    }  
}