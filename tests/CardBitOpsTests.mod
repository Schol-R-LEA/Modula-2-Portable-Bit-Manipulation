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


MODULE CardBitOpsTests;

FROM STextIO IMPORT WriteString, WriteLn;
FROM SWholeIO IMPORT WriteCard;
FROM CardBitOps IMPORT bit, SetBit, ClearBit,
                       shl, shr, ashr,
                       rotl, rotr,
                       bwNot, bwAnd, bwOr, bwXor;

VAR
   a, b, c, d, e, f, g: CARDINAL;

BEGIN
   a := 0;
   b := 6;
   c := MAX(CARDINAL);
   d := 170;         (* 10101010 *)
   e := 85;          (* 01010101 *)
   f := 0DEADBEEFH;
   g := 080000000H;   (* high bit set *)

   WriteString("a = ");
   WriteCard(a, 1);
   WriteString(", NOT a = ");
   WriteCard(bwNot(a), 1);
   WriteString(", bit 3 is ");
   IF bit(a, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF bit(a, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteString("b = ");
   WriteCard(b, 1);
   WriteString(", NOT b = ");
   WriteCard(bwNot(b), 1);
   WriteString(", bit 3 is ");
   IF bit(b, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF bit(b, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteString("c = ");
   WriteCard(c, 1);
   WriteString(", NOT c = ");
   WriteCard(bwNot(c), 1);
   WriteString(", bit 3 is ");
   IF bit(c, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF bit(c, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;
   WriteLn;

   WriteCard(b, 1);
   WriteString(" shifted left by 1 is ");
   WriteCard(shl(b, 1), 1);
   WriteLn;
   WriteCard(b, 1);
   WriteString(" shifted right by 1 is ");
   WriteCard(shr(b, 1), 1);
   WriteLn;
   WriteLn;

   WriteCard(c, 1);
   WriteString(" shifted left by 2 is ");
   WriteCard(shl(c, 2), 1);
   WriteLn;
   WriteCard(c, 1);
   WriteString(" shifted right by 2 is ");
   WriteCard(shr(c, 2), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" shifted left by 1 is ");
   WriteCard(shl(d, 1), 1);
   WriteLn;
   WriteCard(d, 1);
   WriteString(" shifted right by 1 is ");
   WriteCard(shr(d, 1), 1);
   WriteLn;
   WriteLn;

   WriteCard(e, 1);
   WriteString(" shifted left by 1 is ");
   WriteCard(shl(e, 1), 1);
   WriteLn;
   WriteCard(e, 1);
   WriteString(" shifted right by 1 is ");
   WriteCard(shr(e, 1), 1);
   WriteLn;
   WriteLn;

   WriteCard(f, 1);
   WriteString(" shifted left by 4 is ");
   WriteCard(shl(f, 4), 1);
   WriteLn;
   WriteCard(f, 1);
   WriteString(" shifted right by 4 is ");
   WriteCard(shr(f, 4), 1);
   WriteLn;
   WriteLn;

   WriteCard(g, 1);
   WriteString(" shifted left by 4 is ");
   WriteCard(shl(g, 4), 1);
   WriteLn;
   WriteCard(g, 1);
   WriteString(" shifted right by 4 is ");
   WriteCard(shr(g, 4), 1);
   WriteLn;
   WriteLn;


   WriteCard(f, 2);
   WriteString(" shifted left by 2 is ");
   WriteCard(shl(f, 2), 1);
   WriteLn;

   WriteCard(f, 2);
   WriteString(" shifted right by 2 is ");
   WriteCard(shr(f, 2), 1);
   WriteLn;
   WriteLn;

   WriteCard(d, 1);
   WriteString(" shifted left by 4 is ");
   WriteCard(shl(d, 4), 1);
   WriteLn;
   WriteCard(e, 1);
   WriteString(" shifted left by 5 is ");
   WriteCard(shl(e, 5), 1);
   WriteLn;
   WriteLn;

   WriteCard(c, 1);
   WriteString(" arithmetically shifted right by 4 is ");
   WriteCard(ashr(c, 4), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" arithmetically shifted right by 4 is ");
   WriteCard(ashr(d, 4), 1);
   WriteLn;

   WriteCard(f, 1);
   WriteString(" arithmetically shifted right by 4 is ");
   WriteCard(ashr(f, 4), 1);
   WriteLn;

   WriteCard(g, 1);
   WriteString(" arithmetically shifted right by 4 is ");
   WriteCard(ashr(g, 4), 1);
   WriteLn;
   WriteLn;

   WriteCard(rotr(rotl(b, 1), 1), 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(rotl(b, 1), 1);
   WriteLn;
   WriteCard(rotr(rotl(b, 1), 1), 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(rotr(b, 1), 1);
   WriteLn;
   WriteLn;

   WriteCard(c, 1);
   WriteString(" rotated left by 2 is ");
   WriteCard(rotl(c, 2), 1);
   WriteLn;
   WriteCard(c, 1);
   WriteString(" rotated right by 2 is ");
   WriteCard(rotr(c, 2), 1);
   WriteLn;
   WriteLn;

   WriteCard(rotr(rotl(d, 1), 1), 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(rotl(d, 1), 1);
   WriteLn;
   WriteCard(rotr(rotl(d, 1), 1), 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(rotr(d, 1), 1);
   WriteLn;
   WriteLn;

   WriteCard(e, 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(rotl(e, 1), 1);
   WriteLn;
   WriteCard(e, 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(rotr(e, 1), 1);
   WriteLn;
   WriteLn;

   WriteCard(f, 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(rotl(f, 1), 1);
   WriteLn;
   WriteCard(f, 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(rotr(f, 1), 1);
   WriteLn;
   WriteLn;


   WriteCard(g, 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(rotr(g, 1), 1);
   WriteLn;
   WriteCard(g, 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(rotl(g, 1), 1);
   WriteLn;
   WriteLn;

   WriteCard(d, 1);
   WriteString(" rotated left by 4 is ");
   WriteCard(rotl(d, 4), 1);
   WriteLn;
   WriteCard(e, 1);
   WriteString(" rotated left by 5 is ");
   WriteCard(rotl(e, 5), 1);
   WriteLn;
   WriteCard(f, 1);
   WriteString(" rotated left by 4 is ");
   WriteCard(rotl(f, 4), 1);
   WriteLn;
   WriteCard(g, 1);
   WriteString(" rotated left by 5 is ");
   WriteCard(rotl(g, 5), 1);
   WriteLn;
   WriteLn;

   WriteCard(d, 1);
   WriteString(" AND ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(bwAnd(d, e), 1);
   WriteLn;
   WriteCard(d, 1);
   WriteString(" OR ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(bwOr(d, e), 1);
   WriteLn;
   WriteCard(d, 1);
   WriteString(" XOR ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(bwXor(d, e), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" XOR ");
   WriteCard(e, 1);
   WriteString(" shifted left 1 is ");
   WriteCard(bwXor(d, shl(e, 1)), 1);
   WriteLn;


END CardBitOpsTests.