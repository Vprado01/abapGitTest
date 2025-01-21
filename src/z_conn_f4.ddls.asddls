@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Carrier ID search help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_CONN_F4 as 
select from /dmo/carrier
{
    @UI.lineItem: 
    [{position:10, importance: #HIGH  }]
    key carrier_id as CarrierID,
    @UI.lineItem: 
    [{position:20, importance: #HIGH  }]
    name as Name
    
}
