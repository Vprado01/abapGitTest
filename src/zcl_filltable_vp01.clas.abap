CLASS zcl_filltable_vp01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_filltable_vp01 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*  local_created_by      : abp_creation_user;
*  local_created_at      : abp_creation_tstmpl;
*  local_last_changed_by : abp_locinst_lastchange_user;
*  local_last_changed_at : abp_locinst_lastchange_tstmpl;
*  last_changed_at       : abp_lastchange_tstmpl;
DATA: lv_timestamp TYPE abp_creation_tstmpl.
GET TIME STAMP FIELD lv_timestamp.
      INSERT INTO zaconnectionvp01  VALUES @( VALUE #( client = '100' carrid =  '3' uuid = 1 connid = '519'
                                                airport_from = 'FRA' city_from = 'Frankfurt'
                                                country_from = 'DE' airport_to = 'NRT'
                                                city_to = 'Narita' country_to = 'JP'
                                                local_created_by = sy-uname
                                                local_created_at = lv_timestamp
                                                local_last_changed_by = sy-uname
                                                local_last_changed_at = lv_timestamp
                                                last_changed_at = lv_timestamp ) ).
    INSERT INTO zaconnectionvp01 VALUES @( VALUE #( client = '100' carrid =  '4' uuid = 2 connid = '520'
                                                airport_from = 'JFK' city_from = 'New York'
                                                country_from = 'US' airport_to = 'EZE'
                                                city_to = 'Buenos Aires' country_to = 'AR'
                                                local_created_by = sy-uname
                                                local_created_at = lv_timestamp
                                                local_last_changed_by = sy-uname
                                                local_last_changed_at = lv_timestamp
                                                last_changed_at = lv_timestamp ) ).
    INSERT INTO zaconnectionvp01 VALUES @( VALUE #( client = '100' carrid =  '5' uuid = 3 connid = '521'
                                                airport_from = 'SFO' city_from = 'San Francisco'
                                                country_from = 'US' airport_to = 'HND'
                                                city_to = 'Tokyo' country_to = 'JP'
                                                local_created_by = sy-uname
                                                local_created_at = lv_timestamp
                                                local_last_changed_by = sy-uname
                                                local_last_changed_at = lv_timestamp
                                                last_changed_at = lv_timestamp ) ).

*DELETE FROM zaconnectionvp01.
*out->write( lv_timestamp ).
  ENDMETHOD.
ENDCLASS.
