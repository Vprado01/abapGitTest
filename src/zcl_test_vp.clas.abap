CLASS zcl_test_vp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_vp IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA agencies_upd TYPE TABLE FOR UPDATE /dmo/i_agencytp.

    agencies_upd = VALUE #( ( agencyid = '0700##' name = 'Some fancy new name' ) ).

    MODIFY ENTITIES OF /dmo/i_agencytp
      ENTITY /dmo/agency
      UPDATE FIELDS ( name )
        WITH agencies_upd.

    COMMIT ENTITIES.

    out->write( `Method execution finished!`  ).
*
*    DATA airport_from_id TYPE /DMO/airport_from_id.
*    DATA airport_to_id   TYPE /DMO/airport_to_id.
*
*    DATA airports TYPE TABLE OF /DMO/airport_from_id.
*
*  SELECT SINGLE
*      FROM /dmo/connection
*      FIELDS airport_from_id
*      WHERE carrier_id    = 'LH'
*        AND connection_id = '0400'
*        INTO @airport_from_id.
*
*    out->write( `----------`  ).
*    out->write( `Example 1:`  ).
*
*    out->write( |Flight LH 400 departs from {  airport_from_id }.| ).
*    DATA connection TYPE REF TO lcl_connection.
*    DATA connections TYPE TABLE OF REF TO lcl_connection.
*    DATA carrier_id TYPE /dmo/carrier_id.
*
**    connection = NEW #( carrier )
*    TRY.
*        connection = NEW #( i_carrier_id = 'LH'
*                            i_connection_id = '0400' ).
*    CATCH cx_abap_invalid_value.
*        out->write( `Error` ).
*    ENDTRY.
*
**    TRY.
**        connection->set_attributes(
**          i_carrier_id    = 'LH'
**          i_connection_id =  '0100'
**        ).
**
**        APPEND connection TO connections.
**        out->write( `Method call successful` ).
**      CATCH cx_abap_invalid_value.
**        out->write( `Method call failed` ).
**    ENDTRY.
*
*    TRY.
*        connection->get_attributes(
*          IMPORTING
*            e_carrier_id    = carrier_id ).
*    ENDTRY.
*    out->write( carrier_id ).
*    connection->get_attributes(
*      IMPORTING
*        e_carrier_id    = connection->carrier_id
*        e_connection_id = connection->connection_id
**    ).
*    DATA(result) = connection->get_output( ).
*
*        out->write( result ).
*    " in logical expression
*    IF connection->get_output(  ) IS NOT INITIAL.

    " as operand in a statement
*      LOOP AT connection->get_output(  ) INTO DATA(line).
*        out->write( line ).
*      ENDLOOP.

    "  to supply input parameter of another method
*    out->write( data = connection->get_output( )
*                name = `Test` ).
*    ENDIF.



  ENDMETHOD.
ENDCLASS.
