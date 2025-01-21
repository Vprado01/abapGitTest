*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.

    DATA connection_id TYPE /dmo/connection_id READ-ONLY.
    CLASS-DATA conn_counter TYPE i.
    CLASS-METHODS class_constructor.


    METHODS get_attributes
      EXPORTING
        e_carrier_id    TYPE /dmo/carrier_id
        e_connection_id TYPE /dmo/connection_id.

    METHODS constructor
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id TYPE /dmo/carrier_id
      RAISING
        cx_abap_invalid_value.

    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.
  PRIVATE SECTION.
    DATA carrier_id TYPE /dmo/carrier_id.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD class_constructor.

  ENDMETHOD.

  METHOD constructor.

    connection_id = i_connection_id.
    carrier_id = i_carrier_id.
    conn_counter = conn_counter + 1.

  ENDMETHOD.

*  METHOD set_attributes.
*  if i_carrier_id is initial or i_connection_id is initial.
*    RAISE EXCEPTION type cx_abap_invalid_value.
*  ENDIF.
*    carrier_id = i_carrier_id.
*    connection_id = i_connection_id.
*    conn_counter = conn_counter + 1.
*  ENDMETHOD.

  METHOD get_attributes.
    e_carrier_id = carrier_id.
    e_connection_id = connection_id.
  ENDMETHOD.

  METHOD get_output.

    APPEND |------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id    }| TO r_output.
    APPEND |Connection:  { connection_id }| TO r_output.

  ENDMETHOD.

ENDCLASS.
