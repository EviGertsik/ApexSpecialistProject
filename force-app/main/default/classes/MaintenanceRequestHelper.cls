public class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(Map<Id,Case> applicableCases)
    {
       Map<Id,Integer> mapProduct = new Map<Id, Integer>();
       List<Case> newCases = new List<Case>();

       List<Product2> listProduct = [select Id, Maintenance_cycle__c
                                     From Product2];
       for (Product2 p: listProduct)
       {
           if (p != null)
           {
               if(p.Maintenance_Cycle__c !=null)
               {
                   mapProduct.put(p.Id, Integer.valueOf(p.Maintenance_cycle__c));
               }
           }
       }

       for(Case a: applicableCases.values())
       {
           Case newCase = new Case();
           newCase.Vehicle__c = a.Vehicle__c;
           newCase.Equipment__c = a.equipment__c;
           newCase.Type = 'Routine Maintenance';
           newCase.Subject = String.isBlank(a.Subject) ? 'Routine Maintenance Request' : a.subject;
           newCase.Date_Reported__c = Date.today();
           newCase.AccountId = a.AccountId;
           newCase.ContactId = a.ContactId;
           newCase.AssetId = a.AssetId;
           newCase.Origin = a.Origin;
           newCase.Reason = a.Reason;
           newCase.Date_Due__c = (mapProduct.get(a.Id) != null) ? (Date.today().addDays(Integer.valueOf(mapProduct.get(a.id)))) : (date.today());
           newCases.add(newCase);

       }
       if(newCases.size() > 0)
       {
           insert newCases;
       }
    }        
    
}