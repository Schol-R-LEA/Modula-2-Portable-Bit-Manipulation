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


MODULE BitwiseTests;

FROM STextIO IMPORT WriteString, WriteLn;
FROM SWholeIO IMPORT WriteCard, WriteInt;
FROM Bitwise IMPORT BIT, SETBIT, BWNOT,
                    SHL, SHR, ASHR, ROTL, ROTR,
                    BWAND, BWOR, BWXOR;

VAR
   a, b, c, d, e, f: CARDINAL;
   n, m: INTEGER;

BEGIN
   a := 0;
   b := 6;
   c  := 0FFFFFFFFH;
   d := 170;         (* 10101010 *)
   e := 85;          (* 01010101 *)
   f := 0DEADBEEFH;

   n := 128;
   m := -128;


   WriteString("a = ");
   WriteCard(a, 1);
   WriteString(", NOT a = ");
   WriteCard(BWNOT(a), 1);
   WriteString(", bit 3 is ");
   IF BIT(a, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF BIT(a, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteString("b = ");
   WriteCard(b, 1);
   WriteString(", NOT b = ");
   WriteCard(BWNOT(b), 1);
   WriteString(", bit 3 is ");
   IF BIT(b, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF BIT(b, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteString("c = ");
   WriteCard(c, 1);
   WriteString(", NOT c = ");
   WriteCard(BWNOT(c), 1);
   WriteString(", bit 3 is ");
   IF BIT(c, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF BIT(c, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteCard(b, 1);
   WriteString(" shifted left by 1 is ");
   WriteCard(SHL(b, 1), 1);
   WriteLn;
   WriteCard(b, 1);
   WriteString(" shifted right by 1 is ");
   WriteCard(SHR(b, 1), 1);
   WriteLn;
   WriteCard(c, 1);
   WriteString(" shifted right by 2 is ");
   WriteCard(SHR(c, 2), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" shifted right by 1 is ");
   WriteCard(SHR(d, 1), 1);
   WriteLn;

   WriteCard(e, 1);
   WriteString(" shifted left by 1 is ");
   WriteCard(SHL(e, 1), 1);
   WriteLn;

   WriteCard(f, 2);
   WriteString(" shifted left by 2 is ");
   WriteCard(SHL(f, 2), 1);
   WriteLn;

   WriteCard(f, 2);
   WriteString(" shifted right by 2 is ");
   WriteCard(SHR(f, 2), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" shifted left by 4 is ");
   WriteCard(SHL(d, 4), 1);
   WriteLn;
   WriteCard(e, 1);
   WriteString(" shifted left by 5 is ");
   WriteCard(SHL(e, 5), 1);
   WriteLn;

   WriteInt(n, 1);
   WriteString(" shifted right by 1 is ");
   WriteInt(ASHR(n, 1), 1);
   WriteLn;

   WriteInt(m, 1);
   WriteString(" shifted right by 1 is ");
   WriteInt(ASHR(m, 1), 1);
   WriteLn;


   WriteCard(ROTR(ROTL(b, 1), 1), 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(ROTL(b, 1), 1);
   WriteLn;
   WriteCard(ROTR(ROTL(b, 1), 1), 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(ROTR(b, 1), 1);
   WriteLn;

   WriteCard(ROTR(ROTL(c, 1), 1), 1);
   WriteString(" rotated right by 2 is ");
   WriteCard(ROTR(c, 2), 1);
   WriteLn;

   WriteCard(ROTR(ROTL(d, 1), 1), 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(ROTL(d, 1), 1);
   WriteLn;
   WriteCard(ROTR(ROTL(d, 1), 1), 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(ROTR(d, 1), 1);
   WriteLn;

   WriteCard(ROTR(ROTL(e, 1), 1), 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(ROTL(e, 1), 1);
   WriteLn;
   WriteCard(ROTR(ROTL(e, 1), 1), 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(ROTR(e, 1), 1);
   WriteLn;

   WriteCard(ROTR(ROTL(d, 1), 1), 1);
   WriteString(" rotated left by 4 is ");
   WriteCard(ROTL(d, 4), 1);
   WriteLn;
   WriteCard(ROTR(ROTL(e, 1), 1), 1);
   WriteString(" rotated left by 5 is ");
   WriteCard(ROTL(e, 5), 1);
   WriteLn;


   WriteCard(d, 1);
   WriteString(" AND ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(BWAND(d, e), 1);
   WriteLn;
   WriteCard(d, 1);
   WriteString(" OR ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(BWOR(d, e), 1);
   WriteLn;
   WriteCard(d, 1);
   WriteString(" XOR ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(BWXOR(d, e), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" XOR ");
   WriteCard(e, 1);
   WriteString(" shifted left 1 is ");
   WriteCard(BWXOR(d, SHL(e, 1)), 1);
   WriteLn;


END BitwiseTests.