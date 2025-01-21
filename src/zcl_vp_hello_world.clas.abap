CLASS zcl_vp_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_vp_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


DATA t_numbers type table of i.
data max type i.
CONSTANTS c_1 type i value 1.
constants c_0 TYPE i value 0.
max = 20.
***
do max times.
case sy-index.
when 1.
append c_0 to t_numbers.
when 2.
append c_1 to t_numbers.
when others.
APPEND t_numbers[ sy-index - 1 ] + t_numbers[ sy-index - 2 ] to t_numbers.
ENDCASE.
ENDDO.

loop at t_numbers into data(wa_numbers).
out->write( wa_numbers ).
endloop.


  ENDMETHOD.
ENDCLASS.
