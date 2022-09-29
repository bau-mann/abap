CLASS zcl_secret_handshake DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_commands
      IMPORTING code            TYPE i
      RETURNING VALUE(commands) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_secret_handshake IMPLEMENTATION.

  METHOD get_commands.

    DATA binary_zero TYPE x VALUE 0.
    DATA(binary_code) = CONV xstring( code ).

    DATA x_xstring TYPE xstring.
    DATA x_int TYPE i.
    DATA pow_int type i.
    DATA pow_xstring type xstring.

    DATA(codes_transl) = VALUE string_table(  ( `wink` ) ( `double blink` )  ( `close your eyes` )  ( `jump` ) ).

    LOOP AT codes_transl REFERENCE INTO DATA(command).
      pow_int = 2 ** ( sy-tabix - 1 ).
      pow_xstring = pow_int.
      x_xstring = pow_xstring BIT-AND binary_code.
      x_int = x_xstring.
      "IF CONV xstring( 2 ** ( sy-tabix - 1 ) ) BIT-AND binary_code > binary_zero.
      IF x_int > 0.
        APPEND command->* TO commands.
      ENDIF.
    ENDLOOP.

    x_xstring = binary_code BIT-AND CONV xstring( 16 ).
    x_int = x_xstring.
    "IF binary_code BIT-AND CONV xstring( 16 ) > binary_zero.
    IF x_int > 0.
      DATA(reversed_commands) = VALUE string_table( FOR line IN commands
                                                    INDEX INTO i
                                                    ( commands[ lines( commands ) - i + 1 ] ) ).
      commands = reversed_commands.
    ENDIF.

  ENDMETHOD.

ENDCLASS.