CLASS lcl_handler DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ConnectionVP01
        RESULT result,
      CheckSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR ConnectionVP01~CheckSemanticKey,
      GetCities FOR DETERMINE ON SAVE
        IMPORTING keys FOR ConnectionVP01~getcities.
ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD CheckSemanticKey.

    DATA read_keys   TYPE TABLE FOR READ IMPORT z_r_connvp01.
    DATA connections TYPE TABLE FOR READ RESULT z_r_connvp01.
    DATA reported_record LIKE LINE OF reported-connectionvp01.
    DATA failed_record   LIKE LINE OF failed-connectionvp01.

    read_keys = CORRESPONDING #( keys ).

    READ ENTITIES OF z_r_connvp01 IN LOCAL MODE
           ENTITY ConnectionVP01
           FIELDS ( uuid carrid ConnID )
             WITH read_keys
           RESULT connections.

    LOOP AT connections INTO DATA(connection).
      SELECT FROM zaconnectionvp01 "active
      FIELDS uuid
      WHERE carrid EQ @connection-carrid
        AND connid EQ @connection-connid
        AND uuid   NE @connection-uuid
      UNION
      SELECT FROM zacnnctionvp01_d "draft
      FIELDS uuid
      WHERE carrid EQ @connection-carrid
        AND connid EQ @connection-connid
        AND uuid   NE @connection-uuid
      INTO TABLE @DATA(check_result).

      IF check_result IS NOT INITIAL.
        DATA(message) = me->new_message(
                          id       = 'ZCONNVP01'
                          number   = '001'
                          severity = ms-error
                          v1       = connection-carrid
                          v2       = connection-connid ).
        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-carrid = if_abap_behv=>mk-on. "true
        reported_record-%element-connid = if_abap_behv=>mk-on. "true
        APPEND reported_record TO reported-connectionvp01.

        failed_record-%tky = connection-%tky.
        APPEND failed_record TO failed-connectionvp01.
      ENDIF.


    ENDLOOP.



  ENDMETHOD.

  METHOD GetCities.

    DATA read_keys   TYPE TABLE FOR READ IMPORT z_r_connvp01.
    DATA connections TYPE TABLE FOR READ RESULT z_r_connvp01.
    DATA connections_upd TYPE TABLE FOR UPDATE z_r_connvp01.
*    DATA reported_record LIKE LINE OF reported-connectionvp01.
*    DATA failed_record   LIKE LINE OF failed-connectionvp01.

    read_keys = CORRESPONDING #( keys ).

    READ ENTITIES OF z_r_connvp01 IN LOCAL MODE

        ENTITY ConnectionVP01
        FIELDS ( AirportFrom AirportTo )
          WITH read_keys
        RESULT connections.

    LOOP AT connections INTO DATA(connection).

      SELECT SINGLE
      FROM /dmo/i_airport
      FIELDS City, CountryCode
      WHERE AirportID = @connection-AirportFrom
      INTO ( @connection-CityFrom, @connection-CountryFrom ).

      SELECT SINGLE
      FROM /dmo/i_airport
      FIELDS City, CountryCode
      WHERE AirportID = @connection-AirportTo
      INTO ( @connection-CityTo, @connection-CountryTo ).

      MODIFY connections FROM connection.

    ENDLOOP.

    connections_upd = CORRESPONDING #( connections ).

    MODIFY ENTITIES OF z_r_connvp01 IN LOCAL MODE
        ENTITY ConnectionVP01
        UPDATE
        FIELDS ( CityFrom CountryFrom CityTo CountryTo )
          WITH connections_upd
        REPORTED DATA(reported_record).

    reported-connectionvp01 = CORRESPONDING #( reported_record-connectionvp01 ).

  ENDMETHOD.

ENDCLASS.
