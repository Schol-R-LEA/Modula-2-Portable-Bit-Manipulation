(* Copyright (C) 2024 Alice Osako *)
(*
Modula-2 Portable Bit Manipulation API is free software; you can
redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3, or (at your option)
any later version.

Modula-2 Portable Bit Manipulation API is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along
with this package; see the file COPYING.  If not, write to the Free Software
Foundation, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. *)


IMPLEMENTATION MODULE Bitwise;

IMPORT SYSTEM;

TYPE
   TransferType = (Card, BSet);

   CardinalToBitsetTransfer = RECORD
      CASE tag: TransferType OF
         Card:
            c: CARDINAL; |
         BSet:
            bs: BITSET;
      END;
   END;

CONST
   MAXBITS = 31;   (* This should be set manually for a given version of Modula-2 *)

VAR
   MaxBitmap: BITSET;


PROCEDURE BIT(value: CARDINAL; bitIndex: CARDINAL): BOOLEAN;
(* BIT - Test whether a given bit in a value is set. *)
VAR
   bitmap, bitmask, bit: BITSET;
   target: CARDINAL;

BEGIN
   CardinalToBS(bitmap, value);
   bitmask := MaxBitmap - {bitIndex};
   bit := bitmap - bitmask;
   BSToCardinal(target, bit);
   RETURN target # 0;
END BIT;


PROCEDURE SETBIT(VAR target: CARDINAL; bitIndex: CARDINAL; bit: BOOLEAN);
(* SETBIT - Sets/clears a given bit in a value. *)
VAR
   bitmap: BITSET;

BEGIN
   CardinalToBS(bitmap, target);

   IF bit THEN
      BSToCardinal(target,  bitmap + {bitIndex});
   ELSE
      BSToCardinal(target, bitmap - {bitIndex});
   END;
END SETBIT;


PROCEDURE SHL(value: CARDINAL; shiftFactor: CARDINAL): CARDINAL;
(* SHL - Shift a given value to the left by a certain number of bits. *)
VAR
   i, target: CARDINAL;

BEGIN
   FOR i := 0 TO MAXBITS-shiftFactor DO
      IF BIT(value, i) THEN
         SETBIT(target, i+shiftFactor, TRUE);
      ELSE
         SETBIT(target, i+shiftFactor, FALSE);
      END;
   END;

   FOR i := 0 TO shiftFactor-1 DO
      SETBIT(target, i, FALSE);
   END;

   RETURN target;

END SHL;



PROCEDURE SHR(value: CARDINAL; shiftFactor: CARDINAL): CARDINAL;
(* SHR - Shift a given value to the right by a certain number of bits. *)
VAR
   i, target: CARDINAL;

BEGIN
   FOR i := MAXBITS TO shiftFactor BY -1 DO
      IF BIT(value, i) THEN
         SETBIT(target, i-shiftFactor, TRUE);
      ELSE
         SETBIT(target, i-shiftFactor, FALSE);
      END;
   END;

   FOR i := MAXBITS TO MAXBITS-shiftFactor+1 BY -1 DO
      SETBIT(target, i, FALSE);
   END;

   RETURN target;
END SHR;



PROCEDURE ASHR(value: INTEGER; shiftFactor: CARDINAL): INTEGER;
(* ASHR - Shift a given value to the right by a certain number of bits,
          sign extended.  *)
BEGIN
   RETURN 0;
END ASHR;

PROCEDURE ROTL(value: CARDINAL; shiftFactor: CARDINAL): CARDINAL;
(* ROTL - Rotate a given value to the left by a certain number of bits. *)
BEGIN
   RETURN 0;
END ROTL;

PROCEDURE ROTR(value: CARDINAL; shiftFactor: CARDINAL): CARDINAL;
(* ROTR - Rotate a given value to the right by a certain number of bits. *)

BEGIN
   RETURN 0;
END ROTR;



PROCEDURE BWNOT(value: CARDINAL): CARDINAL;
(* BWNOT - Invert the bits of value. *)
VAR
   bitmap: BITSET;
   target: CARDINAL;

BEGIN
   CardinalToBS(bitmap, value);
   BSToCardinal(target, bitmap / MaxBitmap);
   RETURN target;
END BWNOT;


PROCEDURE BWAND(op1: CARDINAL;  op2: CARDINAL): CARDINAL;
(* BWAND - Returns the bitwise AND of op1 and op2. *)
VAR
   bitmap: ARRAY [0..2] OF BITSET;
   target: CARDINAL;

BEGIN
   CardinalToBS(bitmap[0], op1);
   CardinalToBS(bitmap[1], op2);

   bitmap[2] := bitmap[0] * bitmap[1];

   BSToCardinal(target, bitmap[2]);
   RETURN target;
END BWAND;


PROCEDURE BWOR(op1: CARDINAL;  op2: CARDINAL): CARDINAL;
(* BWOR - Returns the bitwise OR of op1 and op2. *)
VAR
   bitmap: ARRAY [0..2] OF BITSET;
   target: CARDINAL;

BEGIN
   CardinalToBS(bitmap[0], op1);
   CardinalToBS(bitmap[1], op2);

   bitmap[2] := bitmap[0] + bitmap[1];

   BSToCardinal(target, bitmap[2]);
   RETURN target;
END BWOR;


PROCEDURE BWXOR(op1: CARDINAL;  op2: CARDINAL): CARDINAL;
(* BWXOR - Returns the bitwise Exclusive-OR of op1 and op2. *)
VAR
   bitmap: ARRAY [0..2] OF BITSET;
   target: CARDINAL;

BEGIN
   CardinalToBS(bitmap[0], op1);
   CardinalToBS(bitmap[1], op2);

   bitmap[2] := bitmap[0] / bitmap[1];

   BSToCardinal(target, bitmap[2]);
   RETURN target;
END BWXOR;


PROCEDURE CardinalToBS(VAR target: BITSET; source: CARDINAL);
VAR
   xfer: CardinalToBitsetTransfer;

BEGIN
   xfer.tag := Card;
   xfer.c := source;
   xfer.tag := BSet;
   target := xfer.bs;
END CardinalToBS;


PROCEDURE BSToCardinal(VAR target: CARDINAL; source: BITSET);
VAR
   xfer: CardinalToBitsetTransfer;
BEGIN
   xfer.tag := BSet;
   xfer.bs := source;
   xfer.tag := Card;
   target := xfer.c;
END BSToCardinal;


BEGIN
   MaxBitmap := {0..MAXBITS};
END Bitwise.