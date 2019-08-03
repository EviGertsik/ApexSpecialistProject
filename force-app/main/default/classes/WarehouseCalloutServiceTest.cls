@isTest
private class WarehouseCalloutServiceTest 
{
  // implement your mock callout test here
  @IsTest
  static void WarehouseEquipmentSync()
  {
    Test.startTest();
    // Set mock callout class
    Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
    // This causes a fake response to be sent from the class that implenets HttpCalloutMock.
    WarehouseCalloutService.runWarehouseEquipmentSync();
    Test.stopTest();
    System.assertEquals(1, [SELECT count()
                            FROM Product2]);
  }
}