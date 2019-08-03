@isTest
public with sharing class MaintenanceRequestTest 
{
    @isTest
    static void testMaintenanceRequest() 
    {
        List<case> caseList = new List<Case>();
        Product2 prod = new Product2();
        prod.cost__c = 50;
        prod.name = 'Ball Valve 10 cm';
        prod.Lifespan_Months__c = 12;
        prod.Maintenance_Cycle__c = 365;
        prod.Current_Inventory__c = 50;
        prod.Replacement_Part__c = true;
        prod.Warehouse_SKU__c = '100009';
        insert prod;
        System.assertEquals(1, [SELECT count()
                                FROM Product2
                                WHERE Name = 'Ball Valve 10 cm']);
        for(Integer i=1;i<=300;i++)
        {
            Case caseNew = new case();
            caseNew.Subject = 'Maintenance';
            caseNew.Type = 'Other';
            caseNew.Status = 'New';
            caseNew.Equipment__c = prod.Id;
            caseList.add(caseNew);
        }
        Test.startTest();

        insert caseList;
        System.assertEquals(300, [SELECT count()
                                  FROM case
                                  WHERE Type = 'Other']);
        for(Case a : caseList)
        {
            a.type = 'Repair';
            a.status = 'Closed';
        }
        update caseList;
        System.assertEquals(300, [SELECT count()
                                  FROM case
                                  WHERE Type = 'Repair']);
        
        Test.stopTest();
    }
}
