(* Copyright (C) 2024 Alice Osako *)
(*
Modula-2 Portable Bit Manipulation API is free software; you can
redistribute it and/or modify it under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation; either version 3, or (at your option)
any later version.

Modula-2 Portable Bit Manipulation API is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU Lesser General Public License along
with this package; see the file COPYING.  If not, write to the Free Software
Foundation, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. *)


MODULE CardBitOpsTests;

FROM STextIO IMPORT WriteChar, WriteString, WriteLn;
FROM SWholeIO IMPORT WriteCard;
FROM CardBitOps IMPORT BitIndex, BitMax,
                       bit, SetBit, ClearBit, ToggleBit,
                       ClearLSBtoN, ClearMSBtoN,
                       shl, shr, ashr, shlc,
                       rotl, rotr,
                       bwNot, bwAnd, bwOr, bwXor;

TYPE
   TestList = ARRAY [0..7] OF CARDINAL;

CONST
   tests = TestList {0, 1, 6, 170, 85, 0DEADBEEFH, 080000000H, MAX(CARDINAL)};

VAR
   index: CARDINAL;


PROCEDURE WriteCardBits(n: CARDINAL);
VAR
   i: BitIndex;
BEGIN
   FOR i := MAX(BitIndex) TO 0 BY -1 DO
      IF bit(n, i) THEN
         WriteChar('1');
      ELSE
         WriteChar('0');
      END;
      IF (i MOD 4 = 0) AND (i # 0) THEN
         WriteString(" : ");
      END;
   END;
END WriteCardBits;

PROCEDURE WriteTests(n: CARDINAL; list: TestList);
VAR
   index: CARDINAL;

BEGIN
   WriteCard(n, 1);

   WriteString(", ");
   WriteCardBits(n);
   WriteLn;
   WriteString("NOT ");
   WriteCard(bwNot(n), 1);
   WriteString(", ");
   WriteCardBits(bwNot(n));
   WriteLn;
   WriteLn;
   WriteClearLoHi(n);
   WriteLn;
   WriteLn;
   WriteShifts(n, 1);
   WriteLn;
   WriteLn;
   WriteShifts(n, 4);
   WriteLn;
   WriteLn;
   WriteShifts(n, 17);
   WriteLn;
   WriteLn;
   WriteShifts(n, MAX(BitIndex));
   WriteLn;
   WriteLn;
   WriteShifts(n, 0);
   WriteLn;
   WriteLn;
   WriteBitManipulation(n);
   WriteLn;
   WriteLn;
   FOR index := 0 TO 7 DO
      WriteBitwise(n, list[index]);
   END;
   WriteLn;
END WriteTests;


PROCEDURE WriteShifts(n: CARDINAL; shift: BitIndex);
VAR
   carry, withCarry: CARDINAL;

BEGIN
   WriteCard(n, 1);
   WriteString(" shifted left by ");
   WriteCard(shift, 1);
   WriteString(" is ");
   WriteCard(shl(n, shift), 1);
   WriteLn;
   WriteCardBits(n);
   WriteString(" -> ");
   WriteCardBits(shl(n, shift));
   WriteLn;
   WriteCard(n, 1);
   WriteString(" shifted right by ");
   WriteCard(shift, 1);
   WriteString(" is ");
   WriteCard(shr(n, shift), 1);
   WriteLn;
   WriteCardBits(n);
   WriteString(" -> ");
   WriteCardBits(shr(n, shift));
   WriteLn;
   WriteCard(n, 1);
   WriteString(" shifted left with carry by ");
   WriteCard(shift, 1);
   WriteString(" is ");
   withCarry := n;
   shlc(withCarry, carry, shift);
   WriteCard(withCarry, 1);
   WriteLn;
   WriteCardBits(n);
   WriteString(" -> ");
   WriteCardBits(withCarry);
   WriteLn;
   WriteString("Carry: ");
   WriteCardBits(carry);
   WriteLn;
   WriteCard(n, 1);
   WriteString(" arithmetically shifted right by ");
   WriteCard(shift, 1);
   WriteString(" is ");
   WriteCard(ashr(n, shift), 1);
   WriteLn;
   WriteCardBits(n);
   WriteString(" -> ");
   WriteCardBits(ashr(n, shift));
   WriteLn;
   WriteCard(n, 1);
   WriteString(" rotated left by ");
   WriteCard(shift, 1);
   WriteString(" is ");
   WriteCard(rotl(n, shift), 1);
   WriteLn;
   WriteCardBits(n);
   WriteString(" -> ");
   WriteCardBits(rotl(n, shift));
   WriteLn;
   WriteCard(n, 1);
   WriteString(" rotated right by ");
   WriteCard(shift, 1);
   WriteString(" is ");
   WriteCard(rotr(n, shift), 1);
   WriteLn;
   WriteCardBits(n);
   WriteString(" -> ");
   WriteCardBits(rotr(n, shift));
END WriteShifts;


PROCEDURE WriteBitwise(n, m: CARDINAL);
BEGIN
   WriteCard(n, 1);
   WriteString(" AND ");
   WriteCard(m, 1);
   WriteString(" is ");
   WriteCard(bwAnd(n, m), 1);
   WriteLn;
   WriteCard(n, 1);
   WriteString(" OR ");
   WriteCard(m, 1);
   WriteString(" is ");
   WriteCard(bwOr(n, m), 1);
   WriteLn;
   WriteCard(n, 1);
   WriteString(" XOR ");
   WriteCard(m, 1);
   WriteString(" is ");
   WriteCard(bwXor(n, m), 1);
   WriteLn;

   WriteCard(n, 1);
   WriteString(" XOR ");
   WriteCard(m, 1);
   WriteString(" shifted left 1 is ");
   WriteCard(bwXor(n, shl(m, 1)), 1);
   WriteLn;
END WriteBitwise;


PROCEDURE WriteBitManipulation(n: CARDINAL);
VAR
   index, temp: CARDINAL;
BEGIN
   FOR index := 0 TO BitMax DO
      WriteCard(n, 1);
      WriteString(": setting bit ");
      WriteCard(index, 1);
      WriteString(" : ");
      temp := n;
      SetBit(temp, index);
      WriteCard(temp, 1);
      WriteLn;
      WriteCard(n, 1);
      WriteString(": clearing bit ");
      WriteCard(index, 1);
      WriteString(" : ");
      temp := n;
      ClearBit(temp, index);
      WriteCard(temp, 1);
      WriteLn;
      WriteCard(n, 1);
      WriteString(": complementing bit ");
      WriteCard(index, 1);
      WriteString(" : ");
      temp := n;
      ToggleBit(temp, index);
      WriteCard(temp, 1);
      WriteLn;
   END;
END WriteBitManipulation;


PROCEDURE WriteClearLoHi(n: CARDINAL);
VAR
   index: BitIndex;
   temp: CARDINAL;

BEGIN
   FOR index := 0 TO BitMax DO
      WriteCard(n, 1);
      WriteString(": cleared above ");
      WriteCard(index, 2);
      WriteString(": ");
      temp := n;
      ClearMSBtoN(temp, index);
      WriteCardBits(temp);
      WriteLn;
      WriteCard(n, 1);
      WriteString(": cleared below ");
      WriteCard(index, 2);
      WriteString(": ");
      temp := n;
      ClearLSBtoN(temp, index);
      WriteCardBits(temp);
      WriteLn;
   END;
END WriteClearLoHi;

BEGIN
   FOR index := 0 TO 7 DO
      WriteTests(tests[index], tests);
   END;
END CardBitOpsTests.
