From: Meelis Roos <mroos@ut.ee>
Date: Wed, 07 May 2008 20:07:08 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.SOC.4.64.0805072306360.14011@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Meelis, can you provide an assembly listing of that routine?  It's in
> drivers/usb/core/hcd.c.  Alternatively, you could try adding printk
> messages before and after each of those statements, and see how far
> they get.

objdump --disassemble hcd.o

hcd.o:     file format elf64-sparc

Disassembly of section .text:

0000000000000000 <usb_calc_bus_time>:
       0:	80 a2 20 02 	cmp  %o0, 2
       4:	02 40 00 2f 	be,pn   %icc, c0 <usb_calc_bus_time+0xc0>
       8:	80 a2 20 03 	cmp  %o0, 3
       c:	02 40 00 1b 	be,pn   %icc, 78 <usb_calc_bus_time+0x78>
      10:	80 a2 20 01 	cmp  %o0, 1
      14:	02 40 00 04 	be,pn   %icc, 24 <usb_calc_bus_time+0x24>
      18:	90 10 3f ff 	mov  -1, %o0
      1c:	81 c3 e0 08 	retl 
      20:	01 00 00 00 	nop 
      24:	02 ca 40 4f 	brz  %o1, 160 <usb_calc_bus_time+0x160>
      28:	85 2a e0 03 	sll  %o3, 3, %g2
      2c:	87 2a e0 06 	sll  %o3, 6, %g3
      30:	03 0a aa aa 	sethi  %hi(0x2aaaa800), %g1
      34:	86 20 c0 02 	sub  %g3, %g2, %g3
      38:	82 10 62 ab 	or  %g1, 0x2ab, %g1
      3c:	05 00 02 94 	sethi  %hi(0xa5000), %g2
      40:	82 58 c0 01 	smul  %g3, %g1, %g1
      44:	87 38 e0 1f 	sra  %g3, 0x1f, %g3
      48:	84 10 a3 3e 	or  %g2, 0x33e, %g2
      4c:	83 30 70 20 	srlx  %g1, 0x20, %g1
      50:	82 20 40 03 	sub  %g1, %g3, %g1
      54:	07 00 08 00 	sethi  %hi(0x200000), %g3
      58:	82 58 40 02 	smul  %g1, %g2, %g1
      5c:	86 10 e2 0d 	or  %g3, 0x20d, %g3
      60:	05 00 80 5f 	sethi  %hi(0x2017c00), %g2
      64:	85 30 b0 09 	srlx  %g2, 9, %g2
      68:	82 00 40 03 	add  %g1, %g3, %g1
      6c:	83 68 63 e8 	sdivx  %g1, 0x3e8, %g1
      70:	81 c3 e0 08 	retl 
      74:	90 00 40 02 	add  %g1, %g2, %o0
      78:	02 ca 80 2a 	brz  %o2, 120 <usb_calc_bus_time+0x120>
      7c:	85 2a e0 03 	sll  %o3, 3, %g2
      80:	87 2a e0 06 	sll  %o3, 6, %g3
      84:	03 0a aa aa 	sethi  %hi(0x2aaaa800), %g1
      88:	86 20 c0 02 	sub  %g3, %g2, %g3
      8c:	82 10 62 ab 	or  %g1, 0x2ab, %g1
      90:	05 00 9a 99 	sethi  %hi(0x26a6400), %g2
      94:	82 58 c0 01 	smul  %g3, %g1, %g1
      98:	87 38 e0 1f 	sra  %g3, 0x1f, %g3
      9c:	85 30 b0 06 	srlx  %g2, 6, %g2
      a0:	83 30 70 20 	srlx  %g1, 0x20, %g1
      a4:	82 20 40 03 	sub  %g1, %g3, %g1
      a8:	82 00 60 03 	add  %g1, 3, %g1
      ac:	82 58 68 23 	smul  %g1, 0x823, %g1
      b0:	82 00 40 02 	add  %g1, %g2, %g1
      b4:	82 68 63 e8 	udivx  %g1, 0x3e8, %g1
      b8:	81 c3 e0 08 	retl 
      bc:	90 00 60 05 	add  %g1, 5, %o0
      c0:	02 c2 80 3b 	brz,pn   %o2, 1ac <usb_calc_bus_time+0x1ac>
      c4:	82 10 28 13 	mov  0x813, %g1
      c8:	0a c2 40 04 	brnz,pn   %o1, d8 <usb_calc_bus_time+0xd8>
      cc:	91 28 70 02 	sllx  %g1, 2, %o0
      d0:	03 00 1c 61 	sethi  %hi(0x718400), %g1
      d4:	91 30 70 0a 	srlx  %g1, 0xa, %o0
      d8:	85 2a e0 03 	sll  %o3, 3, %g2
      dc:	87 2a e0 06 	sll  %o3, 6, %g3
      e0:	03 0a aa aa 	sethi  %hi(0x2aaaa800), %g1
      e4:	86 20 c0 02 	sub  %g3, %g2, %g3
      e8:	82 10 62 ab 	or  %g1, 0x2ab, %g1
      ec:	05 00 00 51 	sethi  %hi(0x14400), %g2
      f0:	82 58 c0 01 	smul  %g3, %g1, %g1
      f4:	87 38 e0 1f 	sra  %g3, 0x1f, %g3
      f8:	84 10 a2 54 	or  %g2, 0x254, %g2
      fc:	83 30 70 20 	srlx  %g1, 0x20, %g1
     100:	82 20 40 03 	sub  %g1, %g3, %g1
     104:	07 01 f9 cf 	sethi  %hi(0x7e73c00), %g3
     108:	82 58 40 02 	smul  %g1, %g2, %g1
     10c:	87 30 f0 09 	srlx  %g3, 9, %g3
     110:	82 00 40 03 	add  %g1, %g3, %g1
     114:	83 68 63 e8 	sdivx  %g1, 0x3e8, %g1
     118:	81 c3 e0 08 	retl 
     11c:	90 02 00 01 	add  %o0, %g1, %o0
     120:	87 2a e0 06 	sll  %o3, 6, %g3
     124:	03 0a aa aa 	sethi  %hi(0x2aaaa800), %g1
     128:	86 20 c0 02 	sub  %g3, %g2, %g3
     12c:	82 10 62 ab 	or  %g1, 0x2ab, %g1
     130:	05 01 bf 85 	sethi  %hi(0x6fe1400), %g2
     134:	82 58 c0 01 	smul  %g3, %g1, %g1
     138:	87 38 e0 1f 	sra  %g3, 0x1f, %g3
     13c:	85 30 b0 07 	srlx  %g2, 7, %g2
     140:	83 30 70 20 	srlx  %g1, 0x20, %g1
     144:	82 20 40 03 	sub  %g1, %g3, %g1
     148:	82 00 60 03 	add  %g1, 3, %g1
     14c:	82 58 68 23 	smul  %g1, 0x823, %g1
     150:	82 00 40 02 	add  %g1, %g2, %g1
     154:	82 68 63 e8 	udivx  %g1, 0x3e8, %g1
     158:	81 c3 e0 08 	retl 
     15c:	90 00 60 05 	add  %g1, 5, %o0
     160:	87 2a e0 06 	sll  %o3, 6, %g3
     164:	03 0a aa aa 	sethi  %hi(0x2aaaa800), %g1
     168:	86 20 c0 02 	sub  %g3, %g2, %g3
     16c:	82 10 62 ab 	or  %g1, 0x2ab, %g1
     170:	05 00 02 8b 	sethi  %hi(0xa2c00), %g2
     174:	82 58 c0 01 	smul  %g3, %g1, %g1
     178:	87 38 e0 1f 	sra  %g3, 0x1f, %g3
     17c:	84 10 a1 78 	or  %g2, 0x178, %g2
     180:	83 30 70 20 	srlx  %g1, 0x20, %g1
     184:	82 20 40 03 	sub  %g1, %g3, %g1
     188:	07 07 e3 3d 	sethi  %hi(0x1f8cf400), %g3
     18c:	82 58 40 02 	smul  %g1, %g2, %g1
     190:	87 30 f0 08 	srlx  %g3, 8, %g3
     194:	05 01 00 ed 	sethi  %hi(0x403b400), %g2
     198:	85 30 b0 0a 	srlx  %g2, 0xa, %g2
     19c:	82 00 40 03 	add  %g1, %g3, %g1
     1a0:	83 68 63 e8 	sdivx  %g1, 0x3e8, %g1
     1a4:	81 c3 e0 08 	retl 
     1a8:	90 00 40 02 	add  %g1, %g2, %o0
     1ac:	85 2a e0 03 	sll  %o3, 3, %g2
     1b0:	87 2a e0 06 	sll  %o3, 6, %g3
     1b4:	03 0a aa aa 	sethi  %hi(0x2aaaa800), %g1
     1b8:	86 20 c0 02 	sub  %g3, %g2, %g3
     1bc:	82 10 62 ab 	or  %g1, 0x2ab, %g1
     1c0:	05 00 00 51 	sethi  %hi(0x14400), %g2
     1c4:	82 58 c0 01 	smul  %g3, %g1, %g1
     1c8:	87 38 e0 1f 	sra  %g3, 0x1f, %g3
     1cc:	84 10 a2 54 	or  %g2, 0x254, %g2
     1d0:	83 30 70 20 	srlx  %g1, 0x20, %g1
     1d4:	82 20 40 03 	sub  %g1, %g3, %g1
     1d8:	07 01 f9 cf 	sethi  %hi(0x7e73c00), %g3
     1dc:	82 58 40 02 	smul  %g1, %g2, %g1
     1e0:	87 30 f0 09 	srlx  %g3, 9, %g3
     1e4:	05 00 27 7b 	sethi  %hi(0x9dec00), %g2
     1e8:	85 30 b0 0a 	srlx  %g2, 0xa, %g2
     1ec:	82 00 40 03 	add  %g1, %g3, %g1
     1f0:	83 68 63 e8 	sdivx  %g1, 0x3e8, %g1
     1f4:	81 c3 e0 08 	retl 
     1f8:	90 00 40 02 	add  %g1, %g2, %o0
     1fc:	01 00 00 00 	nop 

0000000000000200 <usb_hcd_link_urb_to_ep>:
     200:	c2 0a 60 14 	ldub  [ %o1 + 0x14 ], %g1
     204:	9a 10 00 08 	mov  %o0, %o5
     208:	80 a0 60 00 	cmp  %g1, 0
     20c:	12 40 00 13 	bne,pn   %icc, 258 <usb_hcd_link_urb_to_ep+0x58>
     210:	90 10 3f ff 	mov  -1, %o0
     214:	ce 5a 60 50 	ldx  [ %o1 + 0x50 ], %g7
     218:	c2 01 e0 3c 	ld  [ %g7 + 0x3c ], %g1
     21c:	80 a0 60 00 	cmp  %g1, 0
     220:	02 40 00 0e 	be,pn   %icc, 258 <usb_hcd_link_urb_to_ep+0x58>
     224:	90 10 3f fe 	mov  -2, %o0
     228:	c2 5a 60 48 	ldx  [ %o1 + 0x48 ], %g1
     22c:	07 20 00 00 	sethi  %hi(0x80000000), %g3
     230:	c4 58 63 d8 	ldx  [ %g1 + 0x3d8 ], %g2
     234:	84 08 80 03 	and  %g2, %g3, %g2
     238:	02 c0 80 08 	brz,pn   %g2, 258 <usb_hcd_link_urb_to_ep+0x58>
     23c:	90 10 3f bf 	mov  -65, %o0
     240:	d0 03 61 30 	ld  [ %o5 + 0x130 ], %o0
     244:	80 a2 20 01 	cmp  %o0, 1
     248:	02 40 00 06 	be,pn   %icc, 260 <usb_hcd_link_urb_to_ep+0x60>
     24c:	80 a2 20 84 	cmp  %o0, 0x84
     250:	02 40 00 04 	be,pn   %icc, 260 <usb_hcd_link_urb_to_ep+0x60>
     254:	90 10 3f c6 	mov  -58, %o0
     258:	81 c3 e0 08 	retl 
     25c:	91 3a 20 00 	sra  %o0, 0, %o0
     260:	c0 22 60 18 	clr  [ %o1 + 0x18 ]
     264:	84 02 60 20 	add  %o1, 0x20, %g2
     268:	82 01 e0 10 	add  %g7, 0x10, %g1
     26c:	c6 59 e0 18 	ldx  [ %g7 + 0x18 ], %g3
     270:	90 10 20 00 	clr  %o0
     274:	c2 72 60 20 	stx  %g1, [ %o1 + 0x20 ]
     278:	91 3a 20 00 	sra  %o0, 0, %o0
     27c:	c4 71 e0 18 	stx  %g2, [ %g7 + 0x18 ]
     280:	c4 70 c0 00 	stx  %g2, [ %g3 ]
     284:	81 c3 e0 08 	retl 
     288:	c6 72 60 28 	stx  %g3, [ %o1 + 0x28 ]
     28c:	30 68 00 05 	b,a   %xcc, 2a0 <usb_hcd_unlink_urb_from_ep>
     290:	01 00 00 00 	nop 
     294:	01 00 00 00 	nop 
     298:	01 00 00 00 	nop 
     29c:	01 00 00 00 	nop 

00000000000002a0 <usb_hcd_unlink_urb_from_ep>:
     2a0:	c4 5a 60 28 	ldx  [ %o1 + 0x28 ], %g2
     2a4:	86 02 60 20 	add  %o1, 0x20, %g3
     2a8:	c2 5a 60 20 	ldx  [ %o1 + 0x20 ], %g1
     2ac:	c2 70 80 00 	stx  %g1, [ %g2 ]
     2b0:	c4 70 60 08 	stx  %g2, [ %g1 + 8 ]
     2b4:	c6 72 60 28 	stx  %g3, [ %o1 + 0x28 ]
     2b8:	81 c3 e0 08 	retl 
     2bc:	c6 72 60 20 	stx  %g3, [ %o1 + 0x20 ]

00000000000002c0 <usb_hcd_disable_endpoint>:
     2c0:	9d e3 bf 40 	save  %sp, -192, %sp
     2c4:	d0 5e 20 40 	ldx  [ %i0 + 0x40 ], %o0
     2c8:	c2 5a 20 d8 	ldx  [ %o0 + 0xd8 ], %g1
     2cc:	c2 58 60 70 	ldx  [ %g1 + 0x70 ], %g1
     2d0:	02 c0 40 04 	brz,pn   %g1, 2e0 <usb_hcd_disable_endpoint+0x20>
     2d4:	92 10 00 19 	mov  %i1, %o1
     2d8:	9f c0 40 00 	call  %g1
     2dc:	01 00 00 00 	nop 
     2e0:	81 cf e0 08 	rett  %i7 + 8
     2e4:	01 00 00 00 	nop 
     2e8:	30 68 00 06 	b,a   %xcc, 300 <usb_hcd_get_frame_number>
     2ec:	01 00 00 00 	nop 
     2f0:	01 00 00 00 	nop 
     2f4:	01 00 00 00 	nop 
     2f8:	01 00 00 00 	nop 
     2fc:	01 00 00 00 	nop 

0000000000000300 <usb_hcd_get_frame_number>:
     300:	9d e3 bf 40 	save  %sp, -192, %sp
     304:	d0 5e 20 40 	ldx  [ %i0 + 0x40 ], %o0
     308:	c2 02 21 30 	ld  [ %o0 + 0x130 ], %g1
     30c:	80 88 60 01 	btst  1, %g1
     310:	02 68 00 07 	be  %xcc, 32c <usb_hcd_get_frame_number+0x2c>
     314:	b0 10 3f c6 	mov  -58, %i0
     318:	c4 5a 20 d8 	ldx  [ %o0 + 0xd8 ], %g2
     31c:	c2 58 a0 58 	ldx  [ %g2 + 0x58 ], %g1
     320:	9f c0 40 00 	call  %g1
     324:	01 00 00 00 	nop 
     328:	b0 10 00 08 	mov  %o0, %i0
     32c:	81 cf e0 08 	rett  %i7 + 8
     330:	91 3a 20 00 	sra  %o0, 0, %o0
     334:	30 68 00 03 	b,a   %xcc, 340 <usb_hcd_platform_shutdown>
     338:	01 00 00 00 	nop 
     33c:	01 00 00 00 	nop 

0000000000000340 <usb_hcd_platform_shutdown>:
     340:	9d e3 bf 40 	save  %sp, -192, %sp
     344:	d0 5e 21 78 	ldx  [ %i0 + 0x178 ], %o0
     348:	c2 5a 20 d8 	ldx  [ %o0 + 0xd8 ], %g1
     34c:	c2 58 60 50 	ldx  [ %g1 + 0x50 ], %g1
     350:	02 c0 40 04 	brz,pn   %g1, 360 <usb_hcd_platform_shutdown+0x20>
     354:	01 00 00 00 	nop 
     358:	9f c0 40 00 	call  %g1
     35c:	01 00 00 00 	nop 
     360:	81 cf e0 08 	rett  %i7 + 8
     364:	01 00 00 00 	nop 
     368:	30 68 00 06 	b,a   %xcc, 380 <usb_mon_register>
     36c:	01 00 00 00 	nop 
     370:	01 00 00 00 	nop 
     374:	01 00 00 00 	nop 
     378:	01 00 00 00 	nop 
     37c:	01 00 00 00 	nop 

0000000000000380 <usb_mon_register>:
     380:	05 00 00 00 	sethi  %hi(0), %g2
     384:	86 10 00 08 	mov  %o0, %g3
     388:	c2 58 a0 00 	ldx  [ %g2 ], %g1
     38c:	02 c0 40 04 	brz,pn   %g1, 39c <usb_mon_register+0x1c>
     390:	90 10 3f f0 	mov  -16, %o0
     394:	81 c3 e0 08 	retl 
     398:	91 3a 20 00 	sra  %o0, 0, %o0
     39c:	c6 70 a0 00 	stx  %g3, [ %g2 ]
     3a0:	10 68 00 02 	b  %xcc, 3a8 <usb_mon_register+0x28>
     3a4:	81 43 e0 0f 	membar  #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
     3a8:	90 10 20 00 	clr  %o0
     3ac:	81 c3 e0 08 	retl 
     3b0:	91 3a 20 00 	sra  %o0, 0, %o0
     3b4:	30 68 00 03 	b,a   %xcc, 3c0 <usb_mon_deregister>
     3b8:	01 00 00 00 	nop 
     3bc:	01 00 00 00 	nop 

00000000000003c0 <usb_mon_deregister>:
     3c0:	05 00 00 00 	sethi  %hi(0), %g2
     3c4:	c2 58 a0 00 	ldx  [ %g2 ], %g1
     3c8:	02 c0 40 07 	brz,pn   %g1, 3e4 <usb_mon_deregister+0x24>
     3cc:	11 00 00 00 	sethi  %hi(0), %o0
     3d0:	c0 70 a0 00 	clrx  [ %g2 ]
     3d4:	10 68 00 02 	b  %xcc, 3dc <usb_mon_deregister+0x1c>
     3d8:	81 43 e0 0f 	membar  #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
     3dc:	81 c3 e0 08 	retl 
     3e0:	01 00 00 00 	nop 
     3e4:	90 12 20 00 	mov  %o0, %o0
     3e8:	82 13 c0 00 	mov  %o7, %g1
     3ec:	40 00 00 00 	call  3ec <usb_mon_deregister+0x2c>
     3f0:	9e 10 40 00 	mov  %g1, %o7
     3f4:	01 00 00 00 	nop 
     3f8:	01 00 00 00 	nop 
     3fc:	01 00 00 00 	nop 

0000000000000400 <usb_host_authorized_default_store>:
     400:	9d e3 bf 30 	save  %sp, -208, %sp
     404:	e0 5e 3f b8 	ldx  [ %i0 + -72 ], %l0
     408:	90 10 00 1a 	mov  %i2, %o0
     40c:	02 c4 00 0a 	brz,pn   %l0, 434 <usb_host_authorized_default_store+0x34>
     410:	b0 10 3f ed 	mov  -19, %i0
     414:	13 00 00 00 	sethi  %hi(0), %o1
     418:	94 07 a7 eb 	add  %fp, 0x7eb, %o2
     41c:	92 12 60 00 	mov  %o1, %o1
     420:	40 00 00 00 	call  420 <usb_host_authorized_default_store+0x20>
     424:	b0 10 3f ea 	mov  -22, %i0
     428:	80 a2 20 01 	cmp  %o0, 1
     42c:	02 40 00 04 	be,pn   %icc, 43c <usb_host_authorized_default_store+0x3c>
     430:	c2 07 a7 eb 	ld  [ %fp + 0x7eb ], %g1
     434:	81 cf e0 08 	rett  %i7 + 8
     438:	01 00 00 00 	nop 
     43c:	c6 5c 20 e8 	ldx  [ %l0 + 0xe8 ], %g3
     440:	80 a0 00 01 	cmp  %g0, %g1
     444:	82 10 20 01 	mov  1, %g1
     448:	84 40 20 00 	addc  %g0, 0, %g2
     44c:	83 28 70 3a 	sllx  %g1, 0x3a, %g1
     450:	85 28 b0 3a 	sllx  %g2, 0x3a, %g2
     454:	82 28 c0 01 	andn  %g3, %g1, %g1
     458:	82 10 40 02 	or  %g1, %g2, %g1
     45c:	c2 74 20 e8 	stx  %g1, [ %l0 + 0xe8 ]
     460:	81 cf e0 08 	rett  %i7 + 8
     464:	90 10 00 0b 	mov  %o3, %o0
     468:	30 68 00 06 	b,a   %xcc, 480 <usb_host_authorized_default_show>
     46c:	01 00 00 00 	nop 
     470:	01 00 00 00 	nop 
     474:	01 00 00 00 	nop 
     478:	01 00 00 00 	nop 
     47c:	01 00 00 00 	nop 

0000000000000480 <usb_host_authorized_default_show>:
     480:	9d e3 bf 40 	save  %sp, -192, %sp
     484:	c2 5e 3f b8 	ldx  [ %i0 + -72 ], %g1
     488:	90 10 00 1a 	mov  %i2, %o0
     48c:	02 c0 40 0a 	brz,pn   %g1, 4b4 <usb_host_authorized_default_show+0x34>
     490:	b0 10 3f ed 	mov  -19, %i0
     494:	d6 58 60 e8 	ldx  [ %g1 + 0xe8 ], %o3
     498:	15 00 00 00 	sethi  %hi(0), %o2
     49c:	13 00 00 08 	sethi  %hi(0x2000), %o1
     4a0:	94 12 a0 00 	mov  %o2, %o2
     4a4:	97 32 f0 3a 	srlx  %o3, 0x3a, %o3
     4a8:	40 00 00 00 	call  4a8 <usb_host_authorized_default_show+0x28>
     4ac:	96 0a e0 01 	and  %o3, 1, %o3
     4b0:	b1 3a 20 00 	sra  %o0, 0, %i0
     4b4:	81 cf e0 08 	rett  %i7 + 8
     4b8:	01 00 00 00 	nop 
     4bc:	01 00 00 00 	nop 

00000000000004c0 <usb_deregister_bus>:
     4c0:	9d e3 bf 40 	save  %sp, -192, %sp
     4c4:	d0 5e 00 00 	ldx  [ %i0 ], %o0
     4c8:	40 00 00 00 	call  4c8 <usb_deregister_bus+0x8>
     4cc:	21 00 00 00 	sethi  %hi(0), %l0
     4d0:	d6 46 20 08 	ldsw  [ %i0 + 8 ], %o3
     4d4:	92 10 00 08 	mov  %o0, %o1
     4d8:	11 00 00 00 	sethi  %hi(0), %o0
     4dc:	90 12 20 00 	mov  %o0, %o0	! 0 <usb_calc_bus_time>
     4e0:	d4 5e 00 00 	ldx  [ %i0 ], %o2
     4e4:	40 00 00 00 	call  4e4 <usb_deregister_bus+0x24>
     4e8:	94 02 a1 18 	add  %o2, 0x118, %o2
     4ec:	40 00 00 00 	call  4ec <usb_deregister_bus+0x2c>
     4f0:	90 14 20 00 	mov  %l0, %o0
     4f4:	c6 5e 20 40 	ldx  [ %i0 + 0x40 ], %g3
     4f8:	03 00 10 01 	sethi  %hi(0x400400), %g1
     4fc:	90 14 20 00 	mov  %l0, %o0
     500:	c4 5e 20 38 	ldx  [ %i0 + 0x38 ], %g2
     504:	8f 30 70 01 	srlx  %g1, 1, %g7
     508:	83 30 70 02 	srlx  %g1, 2, %g1
     50c:	c4 70 c0 00 	stx  %g2, [ %g3 ]
     510:	c6 70 a0 08 	stx  %g3, [ %g2 + 8 ]
     514:	c2 76 20 38 	stx  %g1, [ %i0 + 0x38 ]
     518:	40 00 00 00 	call  518 <usb_deregister_bus+0x58>
     51c:	ce 76 20 40 	stx  %g7, [ %i0 + 0x40 ]
     520:	40 00 00 00 	call  520 <usb_deregister_bus+0x60>
     524:	90 10 00 18 	mov  %i0, %o0
     528:	d0 46 20 08 	ldsw  [ %i0 + 8 ], %o0
     52c:	13 00 00 00 	sethi  %hi(0), %o1
     530:	40 00 00 00 	call  530 <usb_deregister_bus+0x70>
     534:	92 12 60 00 	mov  %o1, %o1	! 0 <usb_calc_bus_time>
     538:	f0 5e 20 60 	ldx  [ %i0 + 0x60 ], %i0
     53c:	40 00 00 00 	call  53c <usb_deregister_bus+0x7c>
     540:	81 e8 00 00 	restore 
     544:	01 00 00 00 	nop 
     548:	30 68 00 06 	b,a   %xcc, 560 <usb_remove_hcd>
     54c:	01 00 00 00 	nop 
     550:	01 00 00 00 	nop 
     554:	01 00 00 00 	nop 
     558:	01 00 00 00 	nop 
     55c:	01 00 00 00 	nop 

0000000000000560 <usb_remove_hcd>:
     560:	9d e3 bf 40 	save  %sp, -192, %sp
     564:	40 00 00 00 	call  564 <usb_remove_hcd+0x4>
     568:	d0 5e 00 00 	ldx  [ %i0 ], %o0
     56c:	d4 5e 00 00 	ldx  [ %i0 ], %o2
     570:	92 10 00 08 	mov  %o0, %o1
     574:	11 00 00 00 	sethi  %hi(0), %o0
     578:	d6 46 21 30 	ldsw  [ %i0 + 0x130 ], %o3
     57c:	90 12 20 00 	mov  %o0, %o0
     580:	40 00 00 00 	call  580 <usb_remove_hcd+0x20>
     584:	94 02 a1 18 	add  %o2, 0x118, %o2
     588:	c2 06 21 30 	ld  [ %i0 + 0x130 ], %g1
     58c:	80 88 60 01 	btst  1, %g1
     590:	02 68 00 03 	be  %xcc, 59c <usb_remove_hcd+0x3c>
     594:	82 10 20 85 	mov  0x85, %g1
     598:	c2 26 21 30 	st  %g1, [ %i0 + 0x130 ]
     59c:	91 90 20 0f 	wrpr  0xf, %pil
     5a0:	82 10 3f ff 	mov  -1, %g1
     5a4:	c4 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g2
     5a8:	83 30 70 01 	srlx  %g1, 1, %g1
     5ac:	84 08 80 01 	and  %g2, %g1, %g2
     5b0:	c4 76 20 e8 	stx  %g2, [ %i0 + 0xe8 ]
     5b4:	91 90 20 00 	wrpr  0, %pil
     5b8:	d0 5e 20 30 	ldx  [ %i0 + 0x30 ], %o0
     5bc:	13 00 00 00 	sethi  %hi(0), %o1
     5c0:	21 00 00 00 	sethi  %hi(0), %l0
     5c4:	92 12 60 00 	mov  %o1, %o1
     5c8:	40 00 00 00 	call  5c8 <usb_remove_hcd+0x68>
     5cc:	90 02 21 58 	add  %o0, 0x158, %o0
     5d0:	40 00 00 00 	call  5d0 <usb_remove_hcd+0x70>
     5d4:	90 14 20 00 	mov  %l0, %o0
     5d8:	40 00 00 00 	call  5d8 <usb_remove_hcd+0x78>
     5dc:	90 06 20 30 	add  %i0, 0x30, %o0
     5e0:	40 00 00 00 	call  5e0 <usb_remove_hcd+0x80>
     5e4:	90 14 20 00 	mov  %l0, %o0
     5e8:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
     5ec:	c2 58 a0 48 	ldx  [ %g2 + 0x48 ], %g1
     5f0:	9f c0 40 00 	call  %g1
     5f4:	90 10 00 18 	mov  %i0, %o0
     5f8:	c4 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g2
     5fc:	82 10 20 01 	mov  1, %g1
     600:	90 06 20 a0 	add  %i0, 0xa0, %o0
     604:	83 28 70 3d 	sllx  %g1, 0x3d, %g1
     608:	c0 26 21 30 	clr  [ %i0 + 0x130 ]
     60c:	82 28 80 01 	andn  %g2, %g1, %g1
     610:	40 00 00 00 	call  610 <usb_remove_hcd+0xb0>
     614:	c2 76 20 e8 	stx  %g1, [ %i0 + 0xe8 ]
     618:	d0 06 20 ec 	ld  [ %i0 + 0xec ], %o0
     61c:	80 a2 20 00 	cmp  %o0, 0
     620:	06 40 00 04 	bl,pn   %icc, 630 <usb_remove_hcd+0xd0>
     624:	91 32 20 00 	srl  %o0, 0, %o0
     628:	40 00 00 00 	call  628 <usb_remove_hcd+0xc8>
     62c:	92 10 00 18 	mov  %i0, %o1
     630:	7f ff ff a4 	call  4c0 <usb_deregister_bus>
     634:	90 10 00 18 	mov  %i0, %o0
     638:	40 00 00 00 	call  638 <usb_remove_hcd+0xd8>
     63c:	81 e8 00 00 	restore 
     640:	01 00 00 00 	nop 
     644:	30 68 00 07 	b,a   %xcc, 660 <usb_hcd_check_unlink_urb>
     648:	01 00 00 00 	nop 
     64c:	01 00 00 00 	nop 
     650:	01 00 00 00 	nop 
     654:	01 00 00 00 	nop 
     658:	01 00 00 00 	nop 
     65c:	01 00 00 00 	nop 

0000000000000660 <usb_hcd_check_unlink_urb>:
     660:	9d e3 bf 40 	save  %sp, -192, %sp
     664:	c2 5e 60 50 	ldx  [ %i1 + 0x50 ], %g1
     668:	a0 10 00 18 	mov  %i0, %l0
     66c:	8e 06 60 20 	add  %i1, 0x20, %g7
     670:	86 00 60 10 	add  %g1, 0x10, %g3
     674:	10 68 00 04 	b  %xcc, 684 <usb_hcd_check_unlink_urb+0x24>
     678:	c2 58 60 10 	ldx  [ %g1 + 0x10 ], %g1
     67c:	02 60 00 0c 	be,pn   %xcc, 6ac <usb_hcd_check_unlink_urb+0x4c>
     680:	82 10 00 02 	mov  %g2, %g1
     684:	c4 58 40 00 	ldx  [ %g1 ], %g2
     688:	c7 68 80 00 	prefetch  [ %g2 ], #one_write
     68c:	80 a0 c0 01 	cmp  %g3, %g1
     690:	12 6f ff fb 	bne  %xcc, 67c <usb_hcd_check_unlink_urb+0x1c>
     694:	80 a1 c0 01 	cmp  %g7, %g1
     698:	80 a1 c0 03 	cmp  %g7, %g3
     69c:	02 60 00 04 	be,pn   %xcc, 6ac <usb_hcd_check_unlink_urb+0x4c>
     6a0:	b0 10 3f b3 	mov  -77, %i0
     6a4:	81 cf e0 08 	rett  %i7 + 8
     6a8:	91 3a 20 00 	sra  %o0, 0, %o0
     6ac:	c2 06 60 18 	ld  [ %i1 + 0x18 ], %g1
     6b0:	80 a0 60 00 	cmp  %g1, 0
     6b4:	12 47 ff fc 	bne,pn   %icc, 6a4 <usb_hcd_check_unlink_urb+0x44>
     6b8:	b0 10 3f f0 	mov  -16, %i0
     6bc:	f4 26 60 18 	st  %i2, [ %i1 + 0x18 ]
     6c0:	b4 04 20 e0 	add  %l0, 0xe0, %i2
     6c4:	c2 5c 20 e0 	ldx  [ %l0 + 0xe0 ], %g1
     6c8:	82 08 60 04 	and  %g1, 4, %g1
     6cc:	2a c0 40 07 	brnz,a,pn   %g1, 6e8 <usb_hcd_check_unlink_urb+0x88>
     6d0:	b0 10 20 00 	clr  %i0
     6d4:	c2 5e 60 48 	ldx  [ %i1 + 0x48 ], %g1
     6d8:	c4 58 60 38 	ldx  [ %g1 + 0x38 ], %g2
     6dc:	2a c0 80 05 	brnz,a,pn   %g2, 6f0 <usb_hcd_check_unlink_urb+0x90>
     6e0:	d0 5c 00 00 	ldx  [ %l0 ], %o0
     6e4:	b0 10 20 00 	clr  %i0
     6e8:	81 cf e0 08 	rett  %i7 + 8
     6ec:	91 3a 20 00 	sra  %o0, 0, %o0
     6f0:	40 00 00 00 	call  6f0 <usb_hcd_check_unlink_urb+0x90>
     6f4:	b0 10 20 00 	clr  %i0
     6f8:	d4 5c 00 00 	ldx  [ %l0 ], %o2
     6fc:	92 10 00 08 	mov  %o0, %o1
     700:	11 00 00 00 	sethi  %hi(0), %o0
     704:	90 12 20 00 	mov  %o0, %o0	! 0 <usb_calc_bus_time>
     708:	40 00 00 00 	call  708 <usb_hcd_check_unlink_urb+0xa8>
     70c:	94 02 a1 18 	add  %o2, 0x118, %o2
     710:	92 10 00 1a 	mov  %i2, %o1
     714:	40 00 00 00 	call  714 <usb_hcd_check_unlink_urb+0xb4>
     718:	90 10 20 02 	mov  2, %o0
     71c:	10 6f ff e2 	b  %xcc, 6a4 <usb_hcd_check_unlink_urb+0x44>
     720:	01 00 00 00 	nop 
     724:	30 68 00 07 	b,a   %xcc, 740 <usb_put_hcd>
     728:	01 00 00 00 	nop 
     72c:	01 00 00 00 	nop 
     730:	01 00 00 00 	nop 
     734:	01 00 00 00 	nop 
     738:	01 00 00 00 	nop 
     73c:	01 00 00 00 	nop 

0000000000000740 <usb_put_hcd>:
     740:	02 c2 00 07 	brz,pn   %o0, 75c <usb_put_hcd+0x1c>
     744:	13 00 00 00 	sethi  %hi(0), %o1
     748:	90 02 20 78 	add  %o0, 0x78, %o0
     74c:	92 12 60 00 	mov  %o1, %o1
     750:	82 13 c0 00 	mov  %o7, %g1
     754:	40 00 00 00 	call  754 <usb_put_hcd+0x14>
     758:	9e 10 40 00 	mov  %g1, %o7
     75c:	81 c3 e0 08 	retl 
     760:	01 00 00 00 	nop 
     764:	30 68 00 07 	b,a   %xcc, 780 <hcd_release>
     768:	01 00 00 00 	nop 
     76c:	01 00 00 00 	nop 
     770:	01 00 00 00 	nop 
     774:	01 00 00 00 	nop 
     778:	01 00 00 00 	nop 
     77c:	01 00 00 00 	nop 

0000000000000780 <hcd_release>:
     780:	90 02 3f 88 	add  %o0, -120, %o0
     784:	82 13 c0 00 	mov  %o7, %g1
     788:	40 00 00 00 	call  788 <hcd_release+0x8>
     78c:	9e 10 40 00 	mov  %g1, %o7
     790:	01 00 00 00 	nop 
     794:	30 68 00 03 	b,a   %xcc, 7a0 <usb_get_hcd>
     798:	01 00 00 00 	nop 
     79c:	01 00 00 00 	nop 

00000000000007a0 <usb_get_hcd>:
     7a0:	9d e3 bf 40 	save  %sp, -192, %sp
     7a4:	02 c6 00 04 	brz,pn   %i0, 7b4 <usb_get_hcd+0x14>
     7a8:	01 00 00 00 	nop 
     7ac:	40 00 00 00 	call  7ac <usb_get_hcd+0xc>
     7b0:	90 06 20 78 	add  %i0, 0x78, %o0
     7b4:	81 cf e0 08 	rett  %i7 + 8
     7b8:	01 00 00 00 	nop 
     7bc:	01 00 00 00 	nop 

00000000000007c0 <usb_create_hcd>:
     7c0:	9d e3 bf 40 	save  %sp, -192, %sp
     7c4:	d0 5e 20 10 	ldx  [ %i0 + 0x10 ], %o0
     7c8:	92 10 28 0d 	mov  0x80d, %o1
     7cc:	a0 10 00 18 	mov  %i0, %l0
     7d0:	93 2a 70 04 	sllx  %o1, 4, %o1
     7d4:	40 00 00 00 	call  7d4 <usb_create_hcd+0x14>
     7d8:	90 02 21 38 	add  %o0, 0x138, %o0
     7dc:	02 c2 00 22 	brz,pn   %o0, 864 <usb_create_hcd+0xa4>
     7e0:	b0 10 00 08 	mov  %o0, %i0
     7e4:	d0 76 61 68 	stx  %o0, [ %i1 + 0x168 ]
     7e8:	40 00 00 00 	call  7e8 <usb_create_hcd+0x28>
     7ec:	90 02 20 78 	add  %o0, 0x78, %o0
     7f0:	82 10 20 01 	mov  1, %g1
     7f4:	86 06 20 38 	add  %i0, 0x38, %g3
     7f8:	c2 26 20 1c 	st  %g1, [ %i0 + 0x1c ]
     7fc:	c6 76 20 40 	stx  %g3, [ %i0 + 0x40 ]
     800:	82 10 3f ff 	mov  -1, %g1
     804:	84 10 20 00 	clr  %g2
     808:	c2 26 20 08 	st  %g1, [ %i0 + 8 ]
     80c:	90 06 20 a0 	add  %i0, 0xa0, %o0
     810:	f4 76 20 10 	stx  %i2, [ %i0 + 0x10 ]
     814:	c0 76 20 20 	clrx  [ %i0 + 0x20 ]
     818:	c0 76 20 28 	clrx  [ %i0 + 0x28 ]
     81c:	c0 76 20 30 	clrx  [ %i0 + 0x30 ]
     820:	c0 76 20 48 	clrx  [ %i0 + 0x48 ]
     824:	c0 26 20 50 	clr  [ %i0 + 0x50 ]
     828:	c6 76 20 38 	stx  %g3, [ %i0 + 0x38 ]
     82c:	f2 76 00 00 	stx  %i1, [ %i0 ]
     830:	c2 5e 61 80 	ldx  [ %i1 + 0x180 ], %g1
     834:	85 78 74 01 	movrne  %g1, 1, %g2
     838:	40 00 00 00 	call  838 <usb_create_hcd+0x78>
     83c:	c4 2e 20 18 	stb  %g2, [ %i0 + 0x18 ]
     840:	03 00 00 00 	sethi  %hi(0), %g1
     844:	f0 76 20 c0 	stx  %i0, [ %i0 + 0xc0 ]
     848:	82 10 60 00 	mov  %g1, %g1
     84c:	e0 76 20 d8 	stx  %l0, [ %i0 + 0xd8 ]
     850:	c2 76 20 b8 	stx  %g1, [ %i0 + 0xb8 ]
     854:	c2 5c 20 08 	ldx  [ %l0 + 8 ], %g1
     858:	22 c0 40 05 	brz,a,pn   %g1, 86c <usb_create_hcd+0xac>
     85c:	03 00 00 00 	sethi  %hi(0), %g1
     860:	c2 76 20 80 	stx  %g1, [ %i0 + 0x80 ]
     864:	81 cf e0 08 	rett  %i7 + 8
     868:	01 00 00 00 	nop 
     86c:	82 10 60 00 	mov  %g1, %g1
     870:	c2 76 20 80 	stx  %g1, [ %i0 + 0x80 ]
     874:	81 cf e0 08 	rett  %i7 + 8
     878:	01 00 00 00 	nop 
     87c:	01 00 00 00 	nop 

0000000000000880 <usb_hc_died>:
     880:	9d e3 bf 40 	save  %sp, -192, %sp
     884:	40 00 00 00 	call  884 <usb_hc_died+0x4>
     888:	d0 5e 00 00 	ldx  [ %i0 ], %o0
     88c:	d4 5e 00 00 	ldx  [ %i0 ], %o2
     890:	92 10 00 08 	mov  %o0, %o1
     894:	11 00 00 00 	sethi  %hi(0), %o0
     898:	90 12 20 00 	mov  %o0, %o0	! 0 <usb_calc_bus_time>
     89c:	40 00 00 00 	call  89c <usb_hc_died+0x1c>
     8a0:	94 02 a1 18 	add  %o2, 0x118, %o2
     8a4:	a1 52 00 00 	rdpr  %pil, %l0
     8a8:	91 90 20 0f 	wrpr  0xf, %pil
     8ac:	c4 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g2
     8b0:	06 c0 80 07 	brlz,pn   %g2, 8cc <usb_hc_died+0x4c>
     8b4:	82 10 20 01 	mov  1, %g1
     8b8:	0a c4 00 0f 	brnz,pn   %l0, 8f4 <usb_hc_died+0x74>
     8bc:	82 10 20 00 	clr  %g1
     8c0:	91 90 40 00 	wrpr  %g1, %pil
     8c4:	81 cf e0 08 	rett  %i7 + 8
     8c8:	01 00 00 00 	nop 
     8cc:	d0 5e 20 30 	ldx  [ %i0 + 0x30 ], %o0
     8d0:	92 10 20 00 	clr  %o1
     8d4:	83 28 70 3d 	sllx  %g1, 0x3d, %g1
     8d8:	82 28 80 01 	andn  %g2, %g1, %g1
     8dc:	40 00 00 00 	call  8dc <usb_hc_died+0x5c>
     8e0:	c2 76 20 e8 	stx  %g1, [ %i0 + 0xe8 ]
     8e4:	40 00 00 00 	call  8e4 <usb_hc_died+0x64>
     8e8:	d0 5e 20 30 	ldx  [ %i0 + 0x30 ], %o0
     8ec:	02 fc 3f f5 	brz  %l0, 8c0 <usb_hc_died+0x40>
     8f0:	82 10 20 00 	clr  %g1
     8f4:	91 94 00 00 	wrpr  %l0, %pil
     8f8:	81 cf e0 08 	rett  %i7 + 8
     8fc:	01 00 00 00 	nop 

0000000000000900 <usb_hcd_irq>:
     900:	9d e3 bf 40 	save  %sp, -192, %sp
     904:	c2 06 61 30 	ld  [ %i1 + 0x130 ], %g1
     908:	80 a0 60 00 	cmp  %g1, 0
     90c:	22 40 00 0e 	be,a,pn   %icc, 944 <usb_hcd_irq+0x44>
     910:	b0 10 20 00 	clr  %i0
     914:	c2 5e 60 e0 	ldx  [ %i1 + 0xe0 ], %g1
     918:	82 08 60 02 	and  %g1, 2, %g1
     91c:	02 c0 40 09 	brz,pn   %g1, 940 <usb_hcd_irq+0x40>
     920:	b0 06 60 e0 	add  %i1, 0xe0, %i0
     924:	c4 5e 60 d8 	ldx  [ %i1 + 0xd8 ], %g2
     928:	c2 58 a0 18 	ldx  [ %g2 + 0x18 ], %g1
     92c:	9f c0 40 00 	call  %g1
     930:	90 10 00 19 	mov  %i1, %o0
     934:	80 a2 20 00 	cmp  %o0, 0
     938:	12 40 00 05 	bne,pn   %icc, 94c <usb_hcd_irq+0x4c>
     93c:	92 10 00 18 	mov  %i0, %o1
     940:	b0 10 20 00 	clr  %i0
     944:	81 cf e0 08 	rett  %i7 + 8
     948:	91 3a 20 00 	sra  %o0, 0, %o0
     94c:	40 00 00 00 	call  94c <usb_hcd_irq+0x4c>
     950:	90 10 20 02 	mov  2, %o0
     954:	c2 06 61 30 	ld  [ %i1 + 0x130 ], %g1
     958:	80 a0 60 00 	cmp  %g1, 0
     95c:	12 4f ff fa 	bne  %icc, 944 <usb_hcd_irq+0x44>
     960:	b0 10 20 01 	mov  1, %i0
     964:	40 00 00 00 	call  964 <usb_hcd_irq+0x64>
     968:	90 10 00 19 	mov  %i1, %o0
     96c:	10 6f ff f6 	b  %xcc, 944 <usb_hcd_irq+0x44>
     970:	01 00 00 00 	nop 
     974:	30 68 00 03 	b,a   %xcc, 980 <hcd_free_coherent>
     978:	01 00 00 00 	nop 
     97c:	01 00 00 00 	nop 

0000000000000980 <hcd_free_coherent>:
     980:	9d e3 bf 40 	save  %sp, -192, %sp
     984:	d4 5e 80 00 	ldx  [ %i2 ], %o2
     988:	80 a7 20 02 	cmp  %i4, 2
     98c:	82 02 80 1b 	add  %o2, %i3, %g1
     990:	c6 0a 80 1b 	ldub  [ %o2 + %i3 ], %g3
     994:	c4 08 60 01 	ldub  [ %g1 + 1 ], %g2
     998:	ce 08 60 02 	ldub  [ %g1 + 2 ], %g7
     99c:	d8 08 60 03 	ldub  [ %g1 + 3 ], %o4
     9a0:	87 28 f0 38 	sllx  %g3, 0x38, %g3
     9a4:	85 28 b0 30 	sllx  %g2, 0x30, %g2
     9a8:	da 08 60 04 	ldub  [ %g1 + 4 ], %o5
     9ac:	84 10 80 03 	or  %g2, %g3, %g2
     9b0:	8f 29 f0 28 	sllx  %g7, 0x28, %g7
     9b4:	c6 08 60 05 	ldub  [ %g1 + 5 ], %g3
     9b8:	8e 11 c0 02 	or  %g7, %g2, %g7
     9bc:	99 2b 30 20 	sllx  %o4, 0x20, %o4
     9c0:	c4 08 60 06 	ldub  [ %g1 + 6 ], %g2
     9c4:	98 13 00 07 	or  %o4, %g7, %o4
     9c8:	9b 2b 70 18 	sllx  %o5, 0x18, %o5
     9cc:	ce 08 60 07 	ldub  [ %g1 + 7 ], %g7
     9d0:	9a 13 40 0c 	or  %o5, %o4, %o5
     9d4:	87 28 f0 10 	sllx  %g3, 0x10, %g3
     9d8:	86 10 c0 0d 	or  %g3, %o5, %g3
     9dc:	85 28 b0 08 	sllx  %g2, 8, %g2
     9e0:	84 10 80 03 	or  %g2, %g3, %g2
     9e4:	02 40 00 0a 	be,pn   %icc, a0c <hcd_free_coherent+0x8c>
     9e8:	b8 11 c0 02 	or  %g7, %g2, %i4
     9ec:	d6 06 40 00 	ld  [ %i1 ], %o3
     9f0:	90 10 00 18 	mov  %i0, %o0
     9f4:	40 00 00 00 	call  9f4 <hcd_free_coherent+0x74>
     9f8:	92 06 e0 08 	add  %i3, 8, %o1
     9fc:	f8 76 80 00 	stx  %i4, [ %i2 ]
     a00:	c0 26 40 00 	clr  [ %i1 ]
     a04:	81 cf e0 08 	rett  %i7 + 8
     a08:	01 00 00 00 	nop 
     a0c:	92 10 00 0a 	mov  %o2, %o1
     a10:	90 10 00 1c 	mov  %i4, %o0
     a14:	40 00 00 00 	call  a14 <hcd_free_coherent+0x94>
     a18:	94 10 00 1b 	mov  %i3, %o2
     a1c:	d4 5e 80 00 	ldx  [ %i2 ], %o2
     a20:	90 10 00 18 	mov  %i0, %o0
     a24:	92 06 e0 08 	add  %i3, 8, %o1
     a28:	40 00 00 00 	call  a28 <hcd_free_coherent+0xa8>
     a2c:	d6 06 40 00 	ld  [ %i1 ], %o3
     a30:	f8 76 80 00 	stx  %i4, [ %i2 ]
     a34:	c0 26 40 00 	clr  [ %i1 ]
     a38:	81 cf e0 08 	rett  %i7 + 8
     a3c:	01 00 00 00 	nop 

0000000000000a40 <unmap_urb_for_dma>:
     a40:	9d e3 bf 40 	save  %sp, -192, %sp
     a44:	ce 5e 60 48 	ldx  [ %i1 + 0x48 ], %g7
     a48:	c2 59 e0 38 	ldx  [ %g7 + 0x38 ], %g1
     a4c:	02 c0 40 3a 	brz,pn   %g1, b34 <unmap_urb_for_dma+0xf4>
     a50:	01 00 00 00 	nop 
     a54:	c2 5e 60 50 	ldx  [ %i1 + 0x50 ], %g1
     a58:	c4 08 60 03 	ldub  [ %g1 + 3 ], %g2
     a5c:	80 88 a0 03 	btst  3, %g2
     a60:	02 68 00 1a 	be  %xcc, ac8 <unmap_urb_for_dma+0x88>
     a64:	c6 06 60 60 	ld  [ %i1 + 0x60 ], %g3
     a68:	d4 06 60 74 	ld  [ %i1 + 0x74 ], %o2
     a6c:	80 88 e2 00 	btst  0x200, %g3
     a70:	96 10 20 01 	mov  1, %o3
     a74:	97 66 70 02 	movne  %xcc, 2, %o3
     a78:	80 a2 a0 00 	cmp  %o2, 0
     a7c:	02 40 00 2e 	be,pn   %icc, b34 <unmap_urb_for_dma+0xf4>
     a80:	80 88 e0 04 	btst  4, %g3
     a84:	12 60 00 2c 	bne,pn   %xcc, b34 <unmap_urb_for_dma+0xf4>
     a88:	01 00 00 00 	nop 
     a8c:	c2 0e 20 18 	ldub  [ %i0 + 0x18 ], %g1
     a90:	80 a0 60 00 	cmp  %g1, 0
     a94:	12 40 00 21 	bne,pn   %icc, b18 <unmap_urb_for_dma+0xd8>
     a98:	03 00 00 00 	sethi  %hi(0), %g1
     a9c:	c2 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g1
     aa0:	c4 00 60 20 	ld  [ %g1 + 0x20 ], %g2
     aa4:	80 88 a0 02 	btst  2, %g2
     aa8:	02 68 00 23 	be  %xcc, b34 <unmap_urb_for_dma+0xf4>
     aac:	b4 06 60 68 	add  %i1, 0x68, %i2
     ab0:	c2 5e 60 48 	ldx  [ %i1 + 0x48 ], %g1
     ab4:	b7 3a a0 00 	sra  %o2, 0, %i3
     ab8:	b8 0a e0 03 	and  %o3, 3, %i4
     abc:	f0 58 60 40 	ldx  [ %g1 + 0x40 ], %i0
     ac0:	10 6f ff b0 	b  %xcc, 980 <hcd_free_coherent>
     ac4:	93 ee 60 70 	restore  %i1, 0x70, %o1
     ac8:	80 88 e0 08 	btst  8, %g3
     acc:	32 6f ff e8 	bne,a   %xcc, a6c <unmap_urb_for_dma+0x2c>
     ad0:	d4 06 60 74 	ld  [ %i1 + 0x74 ], %o2
     ad4:	c2 0e 20 18 	ldub  [ %i0 + 0x18 ], %g1
     ad8:	80 a0 60 00 	cmp  %g1, 0
     adc:	12 40 00 18 	bne,pn   %icc, b3c <unmap_urb_for_dma+0xfc>
     ae0:	03 00 00 00 	sethi  %hi(0), %g1
     ae4:	c2 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g1
     ae8:	c4 00 60 20 	ld  [ %g1 + 0x20 ], %g2
     aec:	80 88 a0 02 	btst  2, %g2
     af0:	22 6f ff df 	be,a   %xcc, a6c <unmap_urb_for_dma+0x2c>
     af4:	d4 06 60 74 	ld  [ %i1 + 0x74 ], %o2
     af8:	d0 59 e0 40 	ldx  [ %g7 + 0x40 ], %o0
     afc:	92 06 60 88 	add  %i1, 0x88, %o1
     b00:	94 06 60 80 	add  %i1, 0x80, %o2
     b04:	96 10 20 08 	mov  8, %o3
     b08:	7f ff ff 9e 	call  980 <hcd_free_coherent>
     b0c:	98 10 20 01 	mov  1, %o4
     b10:	10 6f ff d6 	b  %xcc, a68 <unmap_urb_for_dma+0x28>
     b14:	c6 06 60 60 	ld  [ %i1 + 0x60 ], %g3
     b18:	d0 5e 00 00 	ldx  [ %i0 ], %o0
     b1c:	95 3a a0 00 	sra  %o2, 0, %o2
     b20:	c4 58 60 00 	ldx  [ %g1 ], %g2
     b24:	96 0a e0 03 	and  %o3, 3, %o3
     b28:	c2 58 a0 18 	ldx  [ %g2 + 0x18 ], %g1
     b2c:	9f c0 40 00 	call  %g1
     b30:	d2 06 60 70 	ld  [ %i1 + 0x70 ], %o1
     b34:	81 cf e0 08 	rett  %i7 + 8
     b38:	01 00 00 00 	nop 
     b3c:	d0 5e 00 00 	ldx  [ %i0 ], %o0
     b40:	94 10 20 08 	mov  8, %o2
     b44:	c4 58 60 00 	ldx  [ %g1 ], %g2
     b48:	96 10 20 01 	mov  1, %o3
     b4c:	c2 58 a0 18 	ldx  [ %g2 + 0x18 ], %g1
     b50:	9f c0 40 00 	call  %g1
     b54:	d2 06 60 88 	ld  [ %i1 + 0x88 ], %o1
     b58:	10 6f ff c4 	b  %xcc, a68 <unmap_urb_for_dma+0x28>
     b5c:	c6 06 60 60 	ld  [ %i1 + 0x60 ], %g3

0000000000000b60 <usb_hcd_giveback_urb>:
     b60:	9d e3 bf 40 	save  %sp, -192, %sp
     b64:	c2 06 60 18 	ld  [ %i1 + 0x18 ], %g1
     b68:	80 a0 60 00 	cmp  %g1, 0
     b6c:	12 40 00 24 	bne,pn   %icc, bfc <usb_hcd_giveback_urb+0x9c>
     b70:	c0 76 60 08 	clrx  [ %i1 + 8 ]
     b74:	c2 06 60 60 	ld  [ %i1 + 0x60 ], %g1
     b78:	82 08 60 01 	and  %g1, 1, %g1
     b7c:	2a c0 40 29 	brnz,a,pn   %g1, c20 <usb_hcd_giveback_urb+0xc0>
     b80:	c2 06 60 74 	ld  [ %i1 + 0x74 ], %g1
     b84:	90 10 00 18 	mov  %i0, %o0
     b88:	7f ff ff ae 	call  a40 <unmap_urb_for_dma>
     b8c:	92 10 00 19 	mov  %i1, %o1
     b90:	c2 06 20 70 	ld  [ %i0 + 0x70 ], %g1
     b94:	80 a0 60 00 	cmp  %g1, 0
     b98:	12 40 00 11 	bne,pn   %icc, bdc <usb_hcd_giveback_urb+0x7c>
     b9c:	03 00 00 00 	sethi  %hi(0), %g1
     ba0:	40 00 00 00 	call  ba0 <usb_hcd_giveback_urb+0x40>
     ba4:	90 10 00 19 	mov  %i1, %o0
     ba8:	c2 5e 60 a8 	ldx  [ %i1 + 0xa8 ], %g1
     bac:	90 10 00 19 	mov  %i1, %o0
     bb0:	9f c0 40 00 	call  %g1
     bb4:	f4 26 60 5c 	st  %i2, [ %i1 + 0x5c ]
     bb8:	90 10 20 01 	mov  1, %o0
     bbc:	40 00 00 00 	call  bbc <usb_hcd_giveback_urb+0x5c>
     bc0:	92 06 60 10 	add  %i1, 0x10, %o1
     bc4:	c2 0e 60 14 	ldub  [ %i1 + 0x14 ], %g1
     bc8:	80 a0 60 00 	cmp  %g1, 0
     bcc:	32 40 00 0e 	bne,a,pn   %icc, c04 <usb_hcd_giveback_urb+0xa4>
     bd0:	11 00 00 00 	sethi  %hi(0), %o0
     bd4:	40 00 00 00 	call  bd4 <usb_hcd_giveback_urb+0x74>
     bd8:	91 e8 00 19 	restore  %g0, %i1, %o0
     bdc:	90 10 00 18 	mov  %i0, %o0
     be0:	c4 58 60 00 	ldx  [ %g1 ], %g2
     be4:	92 10 00 19 	mov  %i1, %o1
     be8:	c2 58 a0 10 	ldx  [ %g2 + 0x10 ], %g1
     bec:	9f c0 40 00 	call  %g1
     bf0:	94 10 00 1a 	mov  %i2, %o2
     bf4:	10 6f ff eb 	b  %xcc, ba0 <usb_hcd_giveback_urb+0x40>
     bf8:	01 00 00 00 	nop 
     bfc:	10 6f ff e2 	b  %xcc, b84 <usb_hcd_giveback_urb+0x24>
     c00:	b5 38 60 00 	sra  %g1, 0, %i2
     c04:	92 10 20 03 	mov  3, %o1
     c08:	90 12 20 00 	mov  %o0, %o0
     c0c:	94 10 20 01 	mov  1, %o2
     c10:	40 00 00 00 	call  c10 <usb_hcd_giveback_urb+0xb0>
     c14:	96 10 20 00 	clr  %o3
     c18:	10 6f ff ef 	b  %xcc, bd4 <usb_hcd_giveback_urb+0x74>
     c1c:	01 00 00 00 	nop 
     c20:	86 10 20 00 	clr  %g3	! 0 <usb_calc_bus_time>
     c24:	c4 06 60 78 	ld  [ %i1 + 0x78 ], %g2
     c28:	80 a0 80 01 	cmp  %g2, %g1
     c2c:	87 64 e0 01 	movl  %icc, 1, %g3
     c30:	80 a0 00 1a 	cmp  %g0, %i2
     c34:	82 60 3f ff 	subc  %g0, -1, %g1
     c38:	80 88 c0 01 	btst  %g3, %g1
     c3c:	10 6f ff d2 	b  %xcc, b84 <usb_hcd_giveback_urb+0x24>
     c40:	b5 66 67 87 	movne  %icc, -121, %i2
     c44:	30 68 00 07 	b,a   %xcc, c60 <unlink1>
     c48:	01 00 00 00 	nop 
     c4c:	01 00 00 00 	nop 
     c50:	01 00 00 00 	nop 
     c54:	01 00 00 00 	nop 
     c58:	01 00 00 00 	nop 
     c5c:	01 00 00 00 	nop 

0000000000000c60 <unlink1>:
     c60:	9d e3 bf 40 	save  %sp, -192, %sp
     c64:	c4 5e 60 48 	ldx  [ %i1 + 0x48 ], %g2
     c68:	c2 58 a0 38 	ldx  [ %g2 + 0x38 ], %g1
     c6c:	02 c0 40 0b 	brz,pn   %g1, c98 <unlink1+0x38>
     c70:	90 10 00 18 	mov  %i0, %o0
     c74:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
     c78:	92 10 00 19 	mov  %i1, %o1
     c7c:	c2 58 a0 68 	ldx  [ %g2 + 0x68 ], %g1
     c80:	9f c0 40 00 	call  %g1
     c84:	94 10 00 1a 	mov  %i2, %o2
     c88:	a0 10 00 08 	mov  %o0, %l0
     c8c:	b1 3c 20 00 	sra  %l0, 0, %i0
     c90:	81 cf e0 08 	rett  %i7 + 8
     c94:	01 00 00 00 	nop 
     c98:	a3 52 00 00 	rdpr  %pil, %l1
     c9c:	91 90 20 0f 	wrpr  0xf, %pil
     ca0:	90 10 00 18 	mov  %i0, %o0
     ca4:	92 10 00 19 	mov  %i1, %o1
     ca8:	40 00 00 00 	call  ca8 <unlink1+0x48>
     cac:	94 10 00 1a 	mov  %i2, %o2
     cb0:	a0 92 20 00 	orcc  %o0, 0, %l0
     cb4:	12 48 00 1b 	bne  %icc, d20 <unlink1+0xc0>
     cb8:	01 00 00 00 	nop 
     cbc:	c2 5e 60 50 	ldx  [ %i1 + 0x50 ], %g1
     cc0:	c4 08 60 02 	ldub  [ %g1 + 2 ], %g2
     cc4:	80 88 a0 0f 	btst  0xf, %g2
     cc8:	02 68 00 16 	be  %xcc, d20 <unlink1+0xc0>
     ccc:	01 00 00 00 	nop 
     cd0:	c2 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g1
     cd4:	83 30 70 3e 	srlx  %g1, 0x3e, %g1
     cd8:	82 08 60 01 	and  %g1, 1, %g1
     cdc:	02 c0 40 1b 	brz,pn   %g1, d48 <unlink1+0xe8>
     ce0:	01 00 00 00 	nop 
     ce4:	c2 5e 20 d0 	ldx  [ %i0 + 0xd0 ], %g1
     ce8:	80 a6 40 01 	cmp  %i1, %g1
     cec:	12 68 00 0d 	bne  %xcc, d20 <unlink1+0xc0>
     cf0:	86 06 60 20 	add  %i1, 0x20, %g3
     cf4:	c0 76 20 d0 	clrx  [ %i0 + 0xd0 ]
     cf8:	90 10 00 18 	mov  %i0, %o0
     cfc:	c2 5e 60 28 	ldx  [ %i1 + 0x28 ], %g1
     d00:	92 10 00 19 	mov  %i1, %o1
     d04:	94 10 00 1a 	mov  %i2, %o2
     d08:	c4 5e 60 20 	ldx  [ %i1 + 0x20 ], %g2
     d0c:	c4 70 40 00 	stx  %g2, [ %g1 ]
     d10:	c2 70 a0 08 	stx  %g1, [ %g2 + 8 ]
     d14:	c6 76 60 28 	stx  %g3, [ %i1 + 0x28 ]
     d18:	40 00 00 00 	call  d18 <unlink1+0xb8>
     d1c:	c6 76 60 20 	stx  %g3, [ %i1 + 0x20 ]
     d20:	02 cc 40 06 	brz  %l1, d38 <unlink1+0xd8>
     d24:	82 10 20 00 	clr  %g1
     d28:	91 94 40 00 	wrpr  %l1, %pil
     d2c:	b1 3c 20 00 	sra  %l0, 0, %i0
     d30:	81 cf e0 08 	rett  %i7 + 8
     d34:	01 00 00 00 	nop 
     d38:	91 90 40 00 	wrpr  %g1, %pil
     d3c:	b1 3c 20 00 	sra  %l0, 0, %i0
     d40:	81 cf e0 08 	rett  %i7 + 8
     d44:	01 00 00 00 	nop 
     d48:	40 00 00 00 	call  d48 <unlink1+0xe8>
     d4c:	90 06 20 a0 	add  %i0, 0xa0, %o0
     d50:	10 6f ff e6 	b  %xcc, ce8 <unlink1+0x88>
     d54:	c2 5e 20 d0 	ldx  [ %i0 + 0xd0 ], %g1
     d58:	01 00 00 00 	nop 
     d5c:	01 00 00 00 	nop 

0000000000000d60 <usb_hcd_flush_endpoint>:
     d60:	9d e3 bf 40 	save  %sp, -192, %sp
     d64:	02 c6 40 2b 	brz,pn   %i1, e10 <usb_hcd_flush_endpoint+0xb0>
     d68:	01 00 00 00 	nop 
     d6c:	f0 5e 20 40 	ldx  [ %i0 + 0x40 ], %i0
     d70:	91 90 20 0f 	wrpr  0xf, %pil
     d74:	a2 06 60 10 	add  %i1, 0x10, %l1
     d78:	c2 5e 60 10 	ldx  [ %i1 + 0x10 ], %g1
     d7c:	10 68 00 06 	b  %xcc, d94 <usb_hcd_flush_endpoint+0x34>
     d80:	a0 00 7f e0 	add  %g1, -32, %l0
     d84:	80 a0 60 00 	cmp  %g1, 0
     d88:	02 40 00 24 	be,pn   %icc, e18 <usb_hcd_flush_endpoint+0xb8>
     d8c:	01 00 00 00 	nop 
     d90:	a0 00 bf e0 	add  %g2, -32, %l0
     d94:	c4 5c 20 20 	ldx  [ %l0 + 0x20 ], %g2
     d98:	c7 68 80 00 	prefetch  [ %g2 ], #one_write
     d9c:	82 04 20 20 	add  %l0, 0x20, %g1
     da0:	80 a4 40 01 	cmp  %l1, %g1
     da4:	32 6f ff f8 	bne,a   %xcc, d84 <usb_hcd_flush_endpoint+0x24>
     da8:	c2 04 20 18 	ld  [ %l0 + 0x18 ], %g1
     dac:	91 90 20 00 	wrpr  0, %pil
     db0:	c2 5e 60 10 	ldx  [ %i1 + 0x10 ], %g1
     db4:	80 a0 40 11 	cmp  %g1, %l1
     db8:	02 60 00 16 	be,pn   %xcc, e10 <usb_hcd_flush_endpoint+0xb0>
     dbc:	01 00 00 00 	nop 
     dc0:	91 90 20 0f 	wrpr  0xf, %pil
     dc4:	c2 5e 60 10 	ldx  [ %i1 + 0x10 ], %g1
     dc8:	80 a0 40 11 	cmp  %g1, %l1
     dcc:	02 60 00 06 	be,pn   %xcc, de4 <usb_hcd_flush_endpoint+0x84>
     dd0:	b0 10 20 00 	clr  %i0
     dd4:	c2 5e 60 18 	ldx  [ %i1 + 0x18 ], %g1
     dd8:	b0 00 7f e0 	add  %g1, -32, %i0
     ddc:	40 00 00 00 	call  ddc <usb_hcd_flush_endpoint+0x7c>
     de0:	90 10 00 18 	mov  %i0, %o0
     de4:	91 90 20 00 	wrpr  0, %pil
     de8:	22 fe 3f f3 	brz,a   %i0, db4 <usb_hcd_flush_endpoint+0x54>
     dec:	c2 5e 60 10 	ldx  [ %i1 + 0x10 ], %g1
     df0:	40 00 00 00 	call  df0 <usb_hcd_flush_endpoint+0x90>
     df4:	90 10 00 18 	mov  %i0, %o0
     df8:	40 00 00 00 	call  df8 <usb_hcd_flush_endpoint+0x98>
     dfc:	90 10 00 18 	mov  %i0, %o0
     e00:	c2 5e 60 10 	ldx  [ %i1 + 0x10 ], %g1
     e04:	80 a0 40 11 	cmp  %g1, %l1
     e08:	12 6f ff ee 	bne  %xcc, dc0 <usb_hcd_flush_endpoint+0x60>
     e0c:	01 00 00 00 	nop 
     e10:	81 cf e0 08 	rett  %i7 + 8
     e14:	01 00 00 00 	nop 
     e18:	40 00 00 00 	call  e18 <usb_hcd_flush_endpoint+0xb8>
     e1c:	90 10 00 10 	mov  %l0, %o0
     e20:	90 10 00 18 	mov  %i0, %o0
     e24:	92 10 00 10 	mov  %l0, %o1
     e28:	7f ff ff 8e 	call  c60 <unlink1>
     e2c:	94 10 3f c6 	mov  -58, %o2
     e30:	40 00 00 00 	call  e30 <usb_hcd_flush_endpoint+0xd0>
     e34:	90 10 00 10 	mov  %l0, %o0
     e38:	10 6f ff d1 	b  %xcc, d7c <usb_hcd_flush_endpoint+0x1c>
     e3c:	c2 5e 60 10 	ldx  [ %i1 + 0x10 ], %g1

0000000000000e40 <usb_hcd_unlink_urb>:
     e40:	9d e3 bf 40 	save  %sp, -192, %sp
     e44:	c2 5e 20 48 	ldx  [ %i0 + 0x48 ], %g1
     e48:	92 10 00 18 	mov  %i0, %o1
     e4c:	94 10 00 19 	mov  %i1, %o2
     e50:	7f ff ff 84 	call  c60 <unlink1>
     e54:	d0 58 60 40 	ldx  [ %g1 + 0x40 ], %o0
     e58:	80 a2 20 00 	cmp  %o0, 0
     e5c:	91 64 67 dc 	move  %icc, -36, %o0
     e60:	b1 3a 20 00 	sra  %o0, 0, %i0
     e64:	81 cf e0 08 	rett  %i7 + 8
     e68:	01 00 00 00 	nop 
     e6c:	30 68 00 05 	b,a   %xcc, e80 <usb_hcd_poll_rh_status>
     e70:	01 00 00 00 	nop 
     e74:	01 00 00 00 	nop 
     e78:	01 00 00 00 	nop 
     e7c:	01 00 00 00 	nop 

0000000000000e80 <usb_hcd_poll_rh_status>:
     e80:	9d e3 bf 30 	save  %sp, -208, %sp
     e84:	c2 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g1
     e88:	0e c0 40 47 	brgez,pn   %g1, fa4 <usb_hcd_poll_rh_status+0x124>
     e8c:	83 30 70 3e 	srlx  %g1, 0x3e, %g1
     e90:	82 08 60 01 	and  %g1, 1, %g1
     e94:	2a c0 40 06 	brnz,a,pn   %g1, eac <usb_hcd_poll_rh_status+0x2c>
     e98:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
     e9c:	c2 5e 20 d0 	ldx  [ %i0 + 0xd0 ], %g1
     ea0:	02 c0 40 41 	brz,pn   %g1, fa4 <usb_hcd_poll_rh_status+0x124>
     ea4:	01 00 00 00 	nop 
     ea8:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
     eac:	a4 07 a7 e7 	add  %fp, 0x7e7, %l2
     eb0:	90 10 00 18 	mov  %i0, %o0
     eb4:	c2 58 a0 78 	ldx  [ %g2 + 0x78 ], %g1
     eb8:	9f c0 40 00 	call  %g1
     ebc:	92 10 00 12 	mov  %l2, %o1
     ec0:	a2 92 20 00 	orcc  %o0, 0, %l1
     ec4:	04 40 00 1f 	ble,pn   %icc, f40 <usb_hcd_poll_rh_status+0xc0>
     ec8:	86 10 00 08 	mov  %o0, %g3
     ecc:	a7 52 00 00 	rdpr  %pil, %l3
     ed0:	91 90 20 0f 	wrpr  0xf, %pil
     ed4:	e0 5e 20 d0 	ldx  [ %i0 + 0xd0 ], %l0
     ed8:	02 c4 00 3e 	brz,pn   %l0, fd0 <usb_hcd_poll_rh_status+0x150>
     edc:	82 10 20 01 	mov  1, %g1
     ee0:	c4 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g2
     ee4:	92 10 00 12 	mov  %l2, %o1
     ee8:	83 28 70 3c 	sllx  %g1, 0x3c, %g1
     eec:	c0 76 20 d0 	clrx  [ %i0 + 0xd0 ]
     ef0:	95 3c 60 00 	sra  %l1, 0, %o2
     ef4:	82 28 80 01 	andn  %g2, %g1, %g1
     ef8:	c2 76 20 e8 	stx  %g1, [ %i0 + 0xe8 ]
     efc:	d0 5c 20 68 	ldx  [ %l0 + 0x68 ], %o0
     f00:	40 00 00 00 	call  f00 <usb_hcd_poll_rh_status+0x80>
     f04:	c6 24 20 78 	st  %g3, [ %l0 + 0x78 ]
     f08:	c4 5c 20 28 	ldx  [ %l0 + 0x28 ], %g2
     f0c:	86 04 20 20 	add  %l0, 0x20, %g3
     f10:	92 10 00 10 	mov  %l0, %o1
     f14:	c2 5c 20 20 	ldx  [ %l0 + 0x20 ], %g1
     f18:	90 10 00 18 	mov  %i0, %o0
     f1c:	94 10 20 00 	clr  %o2
     f20:	c2 70 80 00 	stx  %g1, [ %g2 ]
     f24:	c4 70 60 08 	stx  %g2, [ %g1 + 8 ]
     f28:	c6 74 20 28 	stx  %g3, [ %l0 + 0x28 ]
     f2c:	40 00 00 00 	call  f2c <usb_hcd_poll_rh_status+0xac>
     f30:	c6 74 20 20 	stx  %g3, [ %l0 + 0x20 ]
     f34:	02 cc c0 1e 	brz  %l3, fac <usb_hcd_poll_rh_status+0x12c>
     f38:	82 10 20 00 	clr  %g1
     f3c:	91 94 c0 00 	wrpr  %l3, %pil
     f40:	c2 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g1
     f44:	85 30 70 3d 	srlx  %g1, 0x3d, %g2
     f48:	83 30 70 3e 	srlx  %g1, 0x3e, %g1
     f4c:	82 08 60 01 	and  %g1, 1, %g1
     f50:	0a c8 40 09 	brnz  %g1, f74 <usb_hcd_poll_rh_status+0xf4>
     f54:	84 08 a0 01 	and  %g2, 1, %g2
     f58:	80 a4 60 00 	cmp  %l1, 0
     f5c:	12 48 00 06 	bne  %icc, f74 <usb_hcd_poll_rh_status+0xf4>
     f60:	84 10 20 00 	clr  %g2
     f64:	c4 5e 20 d0 	ldx  [ %i0 + 0xd0 ], %g2
     f68:	82 10 20 00 	clr  %g1
     f6c:	83 78 b4 01 	movrne  %g2, 1, %g1
     f70:	84 10 00 01 	mov  %g1, %g2
     f74:	80 88 a0 ff 	btst  0xff, %g2
     f78:	02 48 00 0b 	be  %icc, fa4 <usb_hcd_poll_rh_status+0x124>
     f7c:	03 00 00 00 	sethi  %hi(0), %g1
     f80:	90 06 20 a0 	add  %i0, 0xa0, %o0
     f84:	d2 58 60 00 	ldx  [ %g1 ], %o1
     f88:	92 6a 60 19 	udivx  %o1, 0x19, %o1
     f8c:	92 02 60 01 	inc  %o1
     f90:	85 2a 70 03 	sllx  %o1, 3, %g2
     f94:	83 2a 70 05 	sllx  %o1, 5, %g1
     f98:	82 20 40 02 	sub  %g1, %g2, %g1
     f9c:	40 00 00 00 	call  f9c <usb_hcd_poll_rh_status+0x11c>
     fa0:	92 00 40 09 	add  %g1, %o1, %o1
     fa4:	81 cf e0 08 	rett  %i7 + 8
     fa8:	01 00 00 00 	nop 
     fac:	91 90 40 00 	wrpr  %g1, %pil
     fb0:	c2 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g1
     fb4:	85 30 70 3d 	srlx  %g1, 0x3d, %g2
     fb8:	83 30 70 3e 	srlx  %g1, 0x3e, %g1
     fbc:	82 08 60 01 	and  %g1, 1, %g1
     fc0:	0a f8 7f ed 	brnz  %g1, f74 <usb_hcd_poll_rh_status+0xf4>
     fc4:	84 08 a0 01 	and  %g2, 1, %g2
     fc8:	10 6f ff e5 	b  %xcc, f5c <usb_hcd_poll_rh_status+0xdc>
     fcc:	80 a4 60 00 	cmp  %l1, 0
     fd0:	c4 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g2
     fd4:	a2 10 20 00 	clr  %l1
     fd8:	83 28 70 3c 	sllx  %g1, 0x3c, %g1
     fdc:	84 10 80 01 	or  %g2, %g1, %g2
     fe0:	10 6f ff d5 	b  %xcc, f34 <usb_hcd_poll_rh_status+0xb4>
     fe4:	c4 76 20 e8 	stx  %g2, [ %i0 + 0xe8 ]
     fe8:	30 68 00 06 	b,a   %xcc, 1000 <usb_add_hcd>
     fec:	01 00 00 00 	nop 
     ff0:	01 00 00 00 	nop 
     ff4:	01 00 00 00 	nop 
     ff8:	01 00 00 00 	nop 
     ffc:	01 00 00 00 	nop 

0000000000001000 <usb_add_hcd>:
    1000:	9d e3 bf 40 	save  %sp, -192, %sp
    1004:	40 00 00 00 	call  1004 <usb_add_hcd+0x4>
    1008:	d0 5e 00 00 	ldx  [ %i0 ], %o0
    100c:	d4 5e 00 00 	ldx  [ %i0 ], %o2
    1010:	92 10 00 08 	mov  %o0, %o1
    1014:	11 00 00 00 	sethi  %hi(0), %o0
    1018:	d6 5e 20 80 	ldx  [ %i0 + 0x80 ], %o3
    101c:	90 12 20 00 	mov  %o0, %o0
    1020:	40 00 00 00 	call  1020 <usb_add_hcd+0x20>
    1024:	94 02 a1 18 	add  %o2, 0x118, %o2
    1028:	c6 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g3
    102c:	84 10 20 01 	mov  1, %g2
    1030:	92 06 20 e0 	add  %i0, 0xe0, %o1
    1034:	85 28 b0 3a 	sllx  %g2, 0x3a, %g2
    1038:	90 10 20 01 	mov  1, %o0
    103c:	83 30 f0 3b 	srlx  %g3, 0x3b, %g1
    1040:	84 28 c0 02 	andn  %g3, %g2, %g2
    1044:	82 18 60 01 	xor  %g1, 1, %g1
    1048:	82 08 60 01 	and  %g1, 1, %g1
    104c:	83 28 70 3a 	sllx  %g1, 0x3a, %g1
    1050:	84 10 80 01 	or  %g2, %g1, %g2
    1054:	40 00 00 00 	call  1054 <usb_add_hcd+0x54>
    1058:	c4 76 20 e8 	stx  %g2, [ %i0 + 0xe8 ]
    105c:	40 00 00 00 	call  105c <usb_add_hcd+0x5c>
    1060:	90 10 00 18 	mov  %i0, %o0
    1064:	a0 92 20 00 	orcc  %o0, 0, %l0
    1068:	02 40 00 04 	be,pn   %icc, 1078 <usb_add_hcd+0x78>
    106c:	a3 3c 20 00 	sra  %l0, 0, %l1
    1070:	81 c7 e0 08 	ret 
    1074:	91 e8 00 11 	restore  %g0, %l1, %o0
    1078:	27 00 00 00 	sethi  %hi(0), %l3
    107c:	25 00 00 00 	sethi  %hi(0), %l2
    1080:	40 00 00 00 	call  1080 <usb_add_hcd+0x80>
    1084:	90 14 e0 00 	mov  %l3, %o0
    1088:	90 14 a0 00 	mov  %l2, %o0
    108c:	92 10 20 40 	mov  0x40, %o1
    1090:	40 00 00 00 	call  1090 <usb_add_hcd+0x90>
    1094:	94 10 20 01 	mov  1, %o2
    1098:	80 a2 20 3f 	cmp  %o0, 0x3f
    109c:	14 40 00 c0 	bg,pn   %icc, 139c <usb_add_hcd+0x39c>
    10a0:	a0 10 00 08 	mov  %o0, %l0
    10a4:	a3 3a 20 00 	sra  %o0, 0, %l1
    10a8:	a4 14 a0 00 	mov  %l2, %l2
    10ac:	90 10 00 11 	mov  %l1, %o0
    10b0:	40 00 00 00 	call  10b0 <usb_add_hcd+0xb0>
    10b4:	92 10 00 12 	mov  %l2, %o1
    10b8:	03 00 00 00 	sethi  %hi(0), %g1
    10bc:	e0 26 20 08 	st  %l0, [ %i0 + 8 ]
    10c0:	17 00 00 00 	sethi  %hi(0), %o3
    10c4:	d0 58 60 00 	ldx  [ %g1 ], %o0
    10c8:	96 12 e0 00 	mov  %o3, %o3
    10cc:	94 10 20 00 	clr  %o2
    10d0:	d2 5e 00 00 	ldx  [ %i0 ], %o1
    10d4:	40 00 00 00 	call  10d4 <usb_add_hcd+0xd4>
    10d8:	98 10 00 11 	mov  %l1, %o4
    10dc:	d0 76 20 60 	stx  %o0, [ %i0 + 0x60 ]
    10e0:	80 a2 30 00 	cmp  %o0, -4096
    10e4:	08 60 00 b8 	bleu,pn   %xcc, 13c4 <usb_add_hcd+0x3c4>
    10e8:	a0 10 00 08 	mov  %o0, %l0
    10ec:	90 10 00 11 	mov  %l1, %o0
    10f0:	40 00 00 00 	call  10f0 <usb_add_hcd+0xf0>
    10f4:	92 10 00 12 	mov  %l2, %o1
    10f8:	a3 3c 20 00 	sra  %l0, 0, %l1
    10fc:	40 00 00 00 	call  10fc <usb_add_hcd+0xfc>
    1100:	90 14 e0 00 	mov  %l3, %o0
    1104:	80 a4 20 00 	cmp  %l0, 0
    1108:	06 40 00 3e 	bl,pn   %icc, 1200 <usb_add_hcd+0x200>
    110c:	90 10 20 00 	clr  %o0
    1110:	92 10 00 18 	mov  %i0, %o1
    1114:	40 00 00 00 	call  1114 <usb_add_hcd+0x114>
    1118:	94 10 20 00 	clr  %o2
    111c:	02 c2 00 c2 	brz,pn   %o0, 1424 <usb_add_hcd+0x424>
    1120:	a4 10 00 08 	mov  %o0, %l2
    1124:	c2 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g1
    1128:	c4 00 60 20 	ld  [ %g1 + 0x20 ], %g2
    112c:	82 10 20 02 	mov  2, %g1
    1130:	80 88 a0 20 	btst  0x20, %g2
    1134:	05 20 00 00 	sethi  %hi(0x80000000), %g2
    1138:	83 66 70 03 	movne  %xcc, 3, %g1
    113c:	c2 22 20 18 	st  %g1, [ %o0 + 0x18 ]
    1140:	d0 76 20 30 	stx  %o0, [ %i0 + 0x30 ]
    1144:	c2 5a 22 00 	ldx  [ %o0 + 0x200 ], %g1
    1148:	82 10 40 02 	or  %g1, %g2, %g1
    114c:	c2 72 22 00 	stx  %g1, [ %o0 + 0x200 ]
    1150:	d6 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %o3
    1154:	c2 5a e0 28 	ldx  [ %o3 + 0x28 ], %g1
    1158:	22 c0 40 09 	brz,a,pn   %g1, 117c <usb_add_hcd+0x17c>
    115c:	c2 5a e0 18 	ldx  [ %o3 + 0x18 ], %g1
    1160:	9f c0 40 00 	call  %g1
    1164:	90 10 00 18 	mov  %i0, %o0
    1168:	a0 92 20 00 	orcc  %o0, 0, %l0
    116c:	26 40 00 cd 	bl,a,pn   %icc, 14a0 <usb_add_hcd+0x4a0>
    1170:	d0 5e 00 00 	ldx  [ %i0 ], %o0
    1174:	d6 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %o3
    1178:	c2 5a e0 18 	ldx  [ %o3 + 0x18 ], %g1
    117c:	02 c0 40 26 	brz,pn   %g1, 1214 <usb_add_hcd+0x214>
    1180:	a0 06 20 88 	add  %i0, 0x88, %l0
    1184:	d8 46 20 08 	ldsw  [ %i0 + 8 ], %o4
    1188:	15 00 00 00 	sethi  %hi(0), %o2
    118c:	94 12 a0 00 	mov  %o2, %o2	! 0 <usb_calc_bus_time>
    1190:	92 10 20 18 	mov  0x18, %o1
    1194:	d6 5a c0 00 	ldx  [ %o3 ], %o3
    1198:	40 00 00 00 	call  1198 <usb_add_hcd+0x198>
    119c:	90 10 00 10 	mov  %l0, %o0
    11a0:	13 00 00 00 	sethi  %hi(0), %o1
    11a4:	96 10 00 10 	mov  %l0, %o3
    11a8:	90 10 00 19 	mov  %i1, %o0
    11ac:	92 12 60 00 	mov  %o1, %o1
    11b0:	94 10 00 1a 	mov  %i2, %o2
    11b4:	40 00 00 00 	call  11b4 <usb_add_hcd+0x1b4>
    11b8:	98 10 00 18 	mov  %i0, %o4
    11bc:	a0 92 20 00 	orcc  %o0, 0, %l0
    11c0:	02 40 00 a4 	be,pn   %icc, 1450 <usb_add_hcd+0x450>
    11c4:	d0 5e 00 00 	ldx  [ %i0 ], %o0
    11c8:	40 00 00 00 	call  11c8 <usb_add_hcd+0x1c8>
    11cc:	a3 3c 20 00 	sra  %l0, 0, %l1
    11d0:	d4 5e 00 00 	ldx  [ %i0 ], %o2
    11d4:	92 10 00 08 	mov  %o0, %o1
    11d8:	11 00 00 00 	sethi  %hi(0), %o0
    11dc:	90 12 20 00 	mov  %o0, %o0	! 0 <usb_calc_bus_time>
    11e0:	96 10 00 19 	mov  %i1, %o3
    11e4:	40 00 00 00 	call  11e4 <usb_add_hcd+0x1e4>
    11e8:	94 02 a1 18 	add  %o2, 0x118, %o2
    11ec:	c0 76 20 30 	clrx  [ %i0 + 0x30 ]
    11f0:	40 00 00 00 	call  11f0 <usb_add_hcd+0x1f0>
    11f4:	90 10 00 12 	mov  %l2, %o0
    11f8:	7f ff fc b2 	call  4c0 <usb_deregister_bus>
    11fc:	90 10 00 18 	mov  %i0, %o0
    1200:	90 10 00 18 	mov  %i0, %o0
    1204:	40 00 00 00 	call  1204 <usb_add_hcd+0x204>
    1208:	b0 10 00 11 	mov  %l1, %i0
    120c:	81 cf e0 08 	rett  %i7 + 8
    1210:	01 00 00 00 	nop 
    1214:	c4 5e 20 f8 	ldx  [ %i0 + 0xf8 ], %g2
    1218:	82 10 3f ff 	mov  -1, %g1
    121c:	0a c0 80 b7 	brnz,pn   %g2, 14f8 <usb_add_hcd+0x4f8>
    1220:	c2 26 20 ec 	st  %g1, [ %i0 + 0xec ]
    1224:	c2 5a e0 30 	ldx  [ %o3 + 0x30 ], %g1
    1228:	9f c0 40 00 	call  %g1
    122c:	90 10 00 18 	mov  %i0, %o0
    1230:	a0 92 20 00 	orcc  %o0, 0, %l0
    1234:	06 40 00 a5 	bl,pn   %icc, 14c8 <usb_add_hcd+0x4c8>
    1238:	84 10 20 02 	mov  2, %g2
    123c:	c2 06 21 08 	ld  [ %i0 + 0x108 ], %g1
    1240:	90 10 20 01 	mov  1, %o0
    1244:	29 00 00 00 	sethi  %hi(0), %l4
    1248:	80 a0 61 f4 	cmp  %g1, 0x1f4
    124c:	83 67 21 f4 	movgu  %icc, 0x1f4, %g1
    1250:	c2 34 a3 d8 	sth  %g1, [ %l2 + 0x3d8 ]
    1254:	82 10 20 01 	mov  1, %g1
    1258:	f4 5e 20 30 	ldx  [ %i0 + 0x30 ], %i2
    125c:	ea 5e 00 00 	ldx  [ %i0 ], %l5
    1260:	c6 5e a0 40 	ldx  [ %i2 + 0x40 ], %g3
    1264:	c2 26 80 00 	st  %g1, [ %i2 ]
    1268:	c4 20 e0 1c 	st  %g2, [ %g3 + 0x1c ]
    126c:	c2 5e a0 40 	ldx  [ %i2 + 0x40 ], %g1
    1270:	c0 70 60 28 	clrx  [ %g1 + 0x28 ]
    1274:	c0 70 60 20 	clrx  [ %g1 + 0x20 ]
    1278:	d2 5e a0 40 	ldx  [ %i2 + 0x40 ], %o1
    127c:	40 00 00 00 	call  127c <usb_add_hcd+0x27c>
    1280:	92 02 60 20 	add  %o1, 0x20, %o1
    1284:	92 10 20 06 	mov  6, %o1
    1288:	40 00 00 00 	call  1288 <usb_add_hcd+0x288>
    128c:	90 10 00 1a 	mov  %i2, %o0
    1290:	40 00 00 00 	call  1290 <usb_add_hcd+0x290>
    1294:	90 14 e0 00 	mov  %l3, %o0
    1298:	03 00 00 10 	sethi  %hi(0x4000), %g1
    129c:	90 10 00 1a 	mov  %i2, %o0
    12a0:	c2 36 a0 4c 	sth  %g1, [ %i2 + 0x4c ]
    12a4:	40 00 00 00 	call  12a4 <usb_add_hcd+0x2a4>
    12a8:	92 10 20 12 	mov  0x12, %o1
    12ac:	80 a2 20 12 	cmp  %o0, 0x12
    12b0:	02 40 00 14 	be,pn   %icc, 1300 <usb_add_hcd+0x300>
    12b4:	a0 10 00 08 	mov  %o0, %l0
    12b8:	90 15 20 00 	mov  %l4, %o0
    12bc:	40 00 00 00 	call  12bc <usb_add_hcd+0x2bc>
    12c0:	a2 10 3f d8 	mov  -40, %l1
    12c4:	83 3c 20 00 	sra  %l0, 0, %g1
    12c8:	80 a4 20 00 	cmp  %l0, 0
    12cc:	a3 64 c0 01 	movl  %icc, %g1, %l1
    12d0:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
    12d4:	c2 58 a0 48 	ldx  [ %g2 + 0x48 ], %g1
    12d8:	9f c0 40 00 	call  %g1
    12dc:	90 10 00 18 	mov  %i0, %o0
    12e0:	c2 06 20 ec 	ld  [ %i0 + 0xec ], %g1
    12e4:	80 a0 60 00 	cmp  %g1, 0
    12e8:	06 47 ff c1 	bl,pn   %icc, 11ec <usb_add_hcd+0x1ec>
    12ec:	90 10 00 19 	mov  %i1, %o0
    12f0:	40 00 00 00 	call  12f0 <usb_add_hcd+0x2f0>
    12f4:	92 10 00 18 	mov  %i0, %o1
    12f8:	10 6f ff be 	b  %xcc, 11f0 <usb_add_hcd+0x1f0>
    12fc:	c0 76 20 30 	clrx  [ %i0 + 0x30 ]
    1300:	40 00 00 00 	call  1300 <usb_add_hcd+0x300>
    1304:	90 10 00 1a 	mov  %i2, %o0
    1308:	a0 92 20 00 	orcc  %o0, 0, %l0
    130c:	12 40 00 9b 	bne,pn   %icc, 1578 <usb_add_hcd+0x578>
    1310:	90 10 00 15 	mov  %l5, %o0
    1314:	40 00 00 00 	call  1314 <usb_add_hcd+0x314>
    1318:	90 15 20 00 	mov  %l4, %o0
    131c:	91 90 20 0f 	wrpr  0xf, %pil
    1320:	84 10 3f ff 	mov  -1, %g2
    1324:	c2 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g1
    1328:	85 28 b0 3f 	sllx  %g2, 0x3f, %g2
    132c:	82 10 40 02 	or  %g1, %g2, %g1
    1330:	c2 76 20 e8 	stx  %g1, [ %i0 + 0xe8 ]
    1334:	91 90 20 00 	wrpr  0, %pil
    1338:	c2 06 21 30 	ld  [ %i0 + 0x130 ], %g1
    133c:	80 a0 60 00 	cmp  %g1, 0
    1340:	02 40 00 13 	be,pn   %icc, 138c <usb_add_hcd+0x38c>
    1344:	01 00 00 00 	nop 
    1348:	13 00 00 00 	sethi  %hi(0), %o1
    134c:	90 04 a1 58 	add  %l2, 0x158, %o0
    1350:	40 00 00 00 	call  1350 <usb_add_hcd+0x350>
    1354:	92 12 60 00 	mov  %o1, %o1
    1358:	a0 92 20 00 	orcc  %o0, 0, %l0
    135c:	06 40 00 7a 	bl,pn   %icc, 1544 <usb_add_hcd+0x544>
    1360:	82 10 20 03 	mov  3, %g1
    1364:	c4 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g2
    1368:	83 28 70 3d 	sllx  %g1, 0x3d, %g1
    136c:	84 08 80 01 	and  %g2, %g1, %g2
    1370:	80 a0 80 01 	cmp  %g2, %g1
    1374:	12 6f ff 3f 	bne  %xcc, 1070 <usb_add_hcd+0x70>
    1378:	a3 3c 20 00 	sra  %l0, 0, %l1
    137c:	40 00 00 00 	call  137c <usb_add_hcd+0x37c>
    1380:	90 10 00 18 	mov  %i0, %o0
    1384:	10 6f ff 3b 	b  %xcc, 1070 <usb_add_hcd+0x70>
    1388:	01 00 00 00 	nop 
    138c:	40 00 00 00 	call  138c <usb_add_hcd+0x38c>
    1390:	90 10 00 18 	mov  %i0, %o0
    1394:	10 6f ff ee 	b  %xcc, 134c <usb_add_hcd+0x34c>
    1398:	13 00 00 00 	sethi  %hi(0), %o1
    139c:	03 00 00 00 	sethi  %hi(0), %g1
    13a0:	11 00 00 00 	sethi  %hi(0), %o0
    13a4:	d2 58 60 00 	ldx  [ %g1 ], %o1
    13a8:	90 12 20 00 	mov  %o0, %o0
    13ac:	40 00 00 00 	call  13ac <usb_add_hcd+0x3ac>
    13b0:	a2 10 3f f9 	mov  -7, %l1
    13b4:	40 00 00 00 	call  13b4 <usb_add_hcd+0x3b4>
    13b8:	90 14 e0 00 	mov  %l3, %o0
    13bc:	10 6f ff 92 	b  %xcc, 1204 <usb_add_hcd+0x204>
    13c0:	90 10 00 18 	mov  %i0, %o0
    13c4:	f0 72 21 68 	stx  %i0, [ %o0 + 0x168 ]
    13c8:	03 00 00 00 	sethi  %hi(0), %g1
    13cc:	8e 06 20 38 	add  %i0, 0x38, %g7
    13d0:	c4 58 60 00 	ldx  [ %g1 ], %g2
    13d4:	86 10 60 00 	mov  %g1, %g3
    13d8:	90 14 e0 00 	mov  %l3, %o0
    13dc:	ce 70 a0 08 	stx  %g7, [ %g2 + 8 ]
    13e0:	c4 76 20 38 	stx  %g2, [ %i0 + 0x38 ]
    13e4:	c6 76 20 40 	stx  %g3, [ %i0 + 0x40 ]
    13e8:	40 00 00 00 	call  13e8 <usb_add_hcd+0x3e8>
    13ec:	ce 70 60 00 	stx  %g7, [ %g1 ]
    13f0:	40 00 00 00 	call  13f0 <usb_add_hcd+0x3f0>
    13f4:	90 10 00 18 	mov  %i0, %o0
    13f8:	40 00 00 00 	call  13f8 <usb_add_hcd+0x3f8>
    13fc:	d0 5e 00 00 	ldx  [ %i0 ], %o0
    1400:	d4 5e 00 00 	ldx  [ %i0 ], %o2
    1404:	92 10 00 08 	mov  %o0, %o1
    1408:	11 00 00 00 	sethi  %hi(0), %o0
    140c:	d6 46 20 08 	ldsw  [ %i0 + 8 ], %o3
    1410:	90 12 20 00 	mov  %o0, %o0
    1414:	40 00 00 00 	call  1414 <usb_add_hcd+0x414>
    1418:	94 02 a1 18 	add  %o2, 0x118, %o2
    141c:	10 6f ff 3d 	b  %xcc, 1110 <usb_add_hcd+0x110>
    1420:	90 10 20 00 	clr  %o0
    1424:	d0 5e 00 00 	ldx  [ %i0 ], %o0
    1428:	40 00 00 00 	call  1428 <usb_add_hcd+0x428>
    142c:	a2 10 3f f4 	mov  -12, %l1
    1430:	d4 5e 00 00 	ldx  [ %i0 ], %o2
    1434:	92 10 00 08 	mov  %o0, %o1
    1438:	11 00 00 00 	sethi  %hi(0), %o0
    143c:	90 12 20 00 	mov  %o0, %o0	! 0 <usb_calc_bus_time>
    1440:	40 00 00 00 	call  1440 <usb_add_hcd+0x440>
    1444:	94 02 a1 18 	add  %o2, 0x118, %o2
    1448:	10 6f ff 6c 	b  %xcc, 11f8 <usb_add_hcd+0x1f8>
    144c:	01 00 00 00 	nop 
    1450:	40 00 00 00 	call  1450 <usb_add_hcd+0x450>
    1454:	f2 26 20 ec 	st  %i1, [ %i0 + 0xec ]
    1458:	c2 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g1
    145c:	05 00 00 00 	sethi  %hi(0), %g2
    1460:	98 10 a0 00 	mov  %g2, %o4	! 0 <usb_calc_bus_time>
    1464:	c4 00 60 20 	ld  [ %g1 + 0x20 ], %g2
    1468:	80 88 a0 01 	btst  1, %g2
    146c:	12 68 00 04 	bne  %xcc, 147c <usb_add_hcd+0x47c>
    1470:	d4 5e 00 00 	ldx  [ %i0 ], %o2
    1474:	03 00 00 00 	sethi  %hi(0), %g1
    1478:	98 10 60 00 	mov  %g1, %o4	! 0 <usb_calc_bus_time>
    147c:	92 10 00 08 	mov  %o0, %o1
    1480:	da 5e 20 f8 	ldx  [ %i0 + 0xf8 ], %o5
    1484:	11 00 00 00 	sethi  %hi(0), %o0
    1488:	96 10 00 19 	mov  %i1, %o3
    148c:	90 12 20 00 	mov  %o0, %o0
    1490:	40 00 00 00 	call  1490 <usb_add_hcd+0x490>
    1494:	94 02 a1 18 	add  %o2, 0x118, %o2
    1498:	10 6f ff 63 	b  %xcc, 1224 <usb_add_hcd+0x224>
    149c:	d6 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %o3
    14a0:	40 00 00 00 	call  14a0 <usb_add_hcd+0x4a0>
    14a4:	a3 3c 20 00 	sra  %l0, 0, %l1
    14a8:	d4 5e 00 00 	ldx  [ %i0 ], %o2
    14ac:	92 10 00 08 	mov  %o0, %o1
    14b0:	11 00 00 00 	sethi  %hi(0), %o0
    14b4:	90 12 20 00 	mov  %o0, %o0	! 0 <usb_calc_bus_time>
    14b8:	40 00 00 00 	call  14b8 <usb_add_hcd+0x4b8>
    14bc:	94 02 a1 18 	add  %o2, 0x118, %o2
    14c0:	10 6f ff 4c 	b  %xcc, 11f0 <usb_add_hcd+0x1f0>
    14c4:	c0 76 20 30 	clrx  [ %i0 + 0x30 ]
    14c8:	d0 5e 00 00 	ldx  [ %i0 ], %o0
    14cc:	40 00 00 00 	call  14cc <usb_add_hcd+0x4cc>
    14d0:	a3 3c 20 00 	sra  %l0, 0, %l1
    14d4:	d4 5e 00 00 	ldx  [ %i0 ], %o2
    14d8:	92 10 00 08 	mov  %o0, %o1
    14dc:	11 00 00 00 	sethi  %hi(0), %o0
    14e0:	96 10 00 11 	mov  %l1, %o3
    14e4:	90 12 20 00 	mov  %o0, %o0
    14e8:	40 00 00 00 	call  14e8 <usb_add_hcd+0x4e8>
    14ec:	94 02 a1 18 	add  %o2, 0x118, %o2
    14f0:	10 6f ff 7d 	b  %xcc, 12e4 <usb_add_hcd+0x2e4>
    14f4:	c2 06 20 ec 	ld  [ %i0 + 0xec ], %g1
    14f8:	40 00 00 00 	call  14f8 <usb_add_hcd+0x4f8>
    14fc:	d0 5e 00 00 	ldx  [ %i0 ], %o0
    1500:	c2 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g1
    1504:	05 00 00 00 	sethi  %hi(0), %g2
    1508:	96 10 a0 00 	mov  %g2, %o3	! 0 <usb_calc_bus_time>
    150c:	c4 00 60 20 	ld  [ %g1 + 0x20 ], %g2
    1510:	80 88 a0 01 	btst  1, %g2
    1514:	12 68 00 04 	bne  %xcc, 1524 <usb_add_hcd+0x524>
    1518:	d4 5e 00 00 	ldx  [ %i0 ], %o2
    151c:	03 00 00 00 	sethi  %hi(0), %g1
    1520:	96 10 60 00 	mov  %g1, %o3	! 0 <usb_calc_bus_time>
    1524:	92 10 00 08 	mov  %o0, %o1
    1528:	d8 5e 20 f8 	ldx  [ %i0 + 0xf8 ], %o4
    152c:	11 00 00 00 	sethi  %hi(0), %o0
    1530:	90 12 20 00 	mov  %o0, %o0	! 0 <usb_calc_bus_time>
    1534:	40 00 00 00 	call  1534 <usb_add_hcd+0x534>
    1538:	94 02 a1 18 	add  %o2, 0x118, %o2
    153c:	10 6f ff 3a 	b  %xcc, 1224 <usb_add_hcd+0x224>
    1540:	d6 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %o3
    1544:	a3 3c 20 00 	sra  %l0, 0, %l1
    1548:	11 00 00 00 	sethi  %hi(0), %o0
    154c:	92 10 00 11 	mov  %l1, %o1
    1550:	40 00 00 00 	call  1550 <usb_add_hcd+0x550>
    1554:	90 12 20 00 	mov  %o0, %o0
    1558:	40 00 00 00 	call  1558 <usb_add_hcd+0x558>
    155c:	90 14 e0 00 	mov  %l3, %o0
    1560:	40 00 00 00 	call  1560 <usb_add_hcd+0x560>
    1564:	90 06 20 30 	add  %i0, 0x30, %o0
    1568:	40 00 00 00 	call  1568 <usb_add_hcd+0x568>
    156c:	90 14 e0 00 	mov  %l3, %o0
    1570:	10 6f ff 59 	b  %xcc, 12d4 <usb_add_hcd+0x2d4>
    1574:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
    1578:	40 00 00 00 	call  1578 <usb_add_hcd+0x578>
    157c:	a3 3c 20 00 	sra  %l0, 0, %l1
    1580:	92 10 00 08 	mov  %o0, %o1
    1584:	11 00 00 00 	sethi  %hi(0), %o0
    1588:	94 05 61 18 	add  %l5, 0x118, %o2
    158c:	96 06 a1 a0 	add  %i2, 0x1a0, %o3
    1590:	98 10 00 11 	mov  %l1, %o4
    1594:	40 00 00 00 	call  1594 <usb_add_hcd+0x594>
    1598:	90 12 20 00 	mov  %o0, %o0
    159c:	40 00 00 00 	call  159c <usb_add_hcd+0x59c>
    15a0:	90 15 20 00 	mov  %l4, %o0
    15a4:	10 6f ff 4c 	b  %xcc, 12d4 <usb_add_hcd+0x2d4>
    15a8:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
    15ac:	30 68 00 05 	b,a   %xcc, 15c0 <rh_timer_func>
    15b0:	01 00 00 00 	nop 
    15b4:	01 00 00 00 	nop 
    15b8:	01 00 00 00 	nop 
    15bc:	01 00 00 00 	nop 

00000000000015c0 <rh_timer_func>:
    15c0:	82 13 c0 00 	mov  %o7, %g1
    15c4:	40 00 00 00 	call  15c4 <rh_timer_func+0x4>
    15c8:	9e 10 40 00 	mov  %g1, %o7
    15cc:	01 00 00 00 	nop 
    15d0:	30 68 00 04 	b,a   %xcc, 15e0 <usb_hcd_submit_urb>
    15d4:	01 00 00 00 	nop 
    15d8:	01 00 00 00 	nop 
    15dc:	01 00 00 00 	nop 

00000000000015e0 <usb_hcd_submit_urb>:
    15e0:	9d e3 be c0 	save  %sp, -320, %sp
    15e4:	c2 5e 20 48 	ldx  [ %i0 + 0x48 ], %g1
    15e8:	90 10 00 18 	mov  %i0, %o0
    15ec:	a8 06 20 10 	add  %i0, 0x10, %l4
    15f0:	a2 10 00 18 	mov  %i0, %l1
    15f4:	40 00 00 00 	call  15f4 <usb_hcd_submit_urb+0x14>
    15f8:	e6 58 60 40 	ldx  [ %g1 + 0x40 ], %l3
    15fc:	90 10 20 01 	mov  1, %o0
    1600:	40 00 00 00 	call  1600 <usb_hcd_submit_urb+0x20>
    1604:	92 10 00 14 	mov  %l4, %o1
    1608:	d2 5e 20 48 	ldx  [ %i0 + 0x48 ], %o1
    160c:	90 10 20 01 	mov  1, %o0
    1610:	40 00 00 00 	call  1610 <usb_hcd_submit_urb+0x30>
    1614:	92 02 65 28 	add  %o1, 0x528, %o1
    1618:	c2 04 e0 70 	ld  [ %l3 + 0x70 ], %g1
    161c:	80 a0 60 00 	cmp  %g1, 0
    1620:	12 40 00 4d 	bne,pn   %icc, 1754 <usb_hcd_submit_urb+0x174>
    1624:	03 00 00 00 	sethi  %hi(0), %g1
    1628:	ce 5c 60 48 	ldx  [ %l1 + 0x48 ], %g7
    162c:	c2 59 e0 38 	ldx  [ %g7 + 0x38 ], %g1
    1630:	02 c0 40 53 	brz,pn   %g1, 177c <usb_hcd_submit_urb+0x19c>
    1634:	c2 5c 60 50 	ldx  [ %l1 + 0x50 ], %g1
    1638:	c4 08 60 03 	ldub  [ %g1 + 3 ], %g2
    163c:	80 88 a0 03 	btst  3, %g2
    1640:	02 68 00 1c 	be  %xcc, 16b0 <usb_hcd_submit_urb+0xd0>
    1644:	c6 04 60 60 	ld  [ %l1 + 0x60 ], %g3
    1648:	a4 10 20 00 	clr  %l2
    164c:	80 88 e2 00 	btst  0x200, %g3
    1650:	a0 10 20 01 	mov  1, %l0
    1654:	a1 66 70 02 	movne  %xcc, 2, %l0
    1658:	80 a4 a0 00 	cmp  %l2, 0
    165c:	32 48 00 28 	bne,a   %icc, 16fc <usb_hcd_submit_urb+0x11c>
    1660:	c2 04 e0 70 	ld  [ %l3 + 0x70 ], %g1
    1664:	d2 04 60 74 	ld  [ %l1 + 0x74 ], %o1
    1668:	80 a2 60 00 	cmp  %o1, 0
    166c:	12 48 00 55 	bne  %icc, 17c0 <usb_hcd_submit_urb+0x1e0>
    1670:	80 88 e0 04 	btst  4, %g3
    1674:	ce 5c 60 48 	ldx  [ %l1 + 0x48 ], %g7
    1678:	c2 59 e0 38 	ldx  [ %g7 + 0x38 ], %g1
    167c:	02 c0 40 3f 	brz,pn   %g1, 1778 <usb_hcd_submit_urb+0x198>
    1680:	94 10 00 19 	mov  %i1, %o2
    1684:	c4 5c e0 d8 	ldx  [ %l3 + 0xd8 ], %g2
    1688:	90 10 00 13 	mov  %l3, %o0
    168c:	c2 58 a0 60 	ldx  [ %g2 + 0x60 ], %g1
    1690:	9f c0 40 00 	call  %g1
    1694:	92 10 00 11 	mov  %l1, %o1
    1698:	a4 10 00 08 	mov  %o0, %l2
    169c:	80 a4 a0 00 	cmp  %l2, 0
    16a0:	12 40 00 d4 	bne,pn   %icc, 19f0 <usb_hcd_submit_urb+0x410>
    16a4:	b1 3c a0 00 	sra  %l2, 0, %i0
    16a8:	81 cf e0 08 	rett  %i7 + 8
    16ac:	01 00 00 00 	nop 
    16b0:	80 88 e0 08 	btst  8, %g3
    16b4:	12 68 00 0b 	bne  %xcc, 16e0 <usb_hcd_submit_urb+0x100>
    16b8:	80 88 e2 00 	btst  0x200, %g3
    16bc:	c2 0c e0 18 	ldub  [ %l3 + 0x18 ], %g1
    16c0:	80 a0 60 00 	cmp  %g1, 0
    16c4:	12 40 00 68 	bne,pn   %icc, 1864 <usb_hcd_submit_urb+0x284>
    16c8:	03 00 00 00 	sethi  %hi(0), %g1
    16cc:	c2 5c e0 d8 	ldx  [ %l3 + 0xd8 ], %g1
    16d0:	c4 00 60 20 	ld  [ %g1 + 0x20 ], %g2
    16d4:	80 88 a0 02 	btst  2, %g2
    16d8:	12 60 00 71 	bne,pn   %xcc, 189c <usb_hcd_submit_urb+0x2bc>
    16dc:	80 88 e2 00 	btst  0x200, %g3
    16e0:	a4 10 20 00 	clr  %l2
    16e4:	a0 10 20 01 	mov  1, %l0
    16e8:	a1 66 70 02 	movne  %xcc, 2, %l0
    16ec:	80 a4 a0 00 	cmp  %l2, 0
    16f0:	22 4f ff de 	be,a   %icc, 1668 <usb_hcd_submit_urb+0x88>
    16f4:	d2 04 60 74 	ld  [ %l1 + 0x74 ], %o1
    16f8:	c2 04 e0 70 	ld  [ %l3 + 0x70 ], %g1
    16fc:	80 a0 60 00 	cmp  %g1, 0
    1700:	12 40 01 63 	bne,pn   %icc, 1c8c <usb_hcd_submit_urb+0x6ac>
    1704:	b1 3c a0 00 	sra  %l2, 0, %i0
    1708:	82 04 60 20 	add  %l1, 0x20, %g1
    170c:	92 10 00 14 	mov  %l4, %o1
    1710:	c2 74 60 28 	stx  %g1, [ %l1 + 0x28 ]
    1714:	c2 74 60 20 	stx  %g1, [ %l1 + 0x20 ]
    1718:	90 10 20 01 	mov  1, %o0
    171c:	40 00 00 00 	call  171c <usb_hcd_submit_urb+0x13c>
    1720:	c0 74 60 08 	clrx  [ %l1 + 8 ]
    1724:	d2 5c 60 48 	ldx  [ %l1 + 0x48 ], %o1
    1728:	90 10 20 01 	mov  1, %o0
    172c:	40 00 00 00 	call  172c <usb_hcd_submit_urb+0x14c>
    1730:	92 02 65 28 	add  %o1, 0x528, %o1
    1734:	c2 0c 60 14 	ldub  [ %l1 + 0x14 ], %g1
    1738:	80 a0 60 00 	cmp  %g1, 0
    173c:	12 40 00 93 	bne,pn   %icc, 1988 <usb_hcd_submit_urb+0x3a8>
    1740:	11 00 00 00 	sethi  %hi(0), %o0
    1744:	40 00 00 00 	call  1744 <usb_hcd_submit_urb+0x164>
    1748:	90 10 00 11 	mov  %l1, %o0
    174c:	81 cf e0 08 	rett  %i7 + 8
    1750:	01 00 00 00 	nop 
    1754:	90 10 00 13 	mov  %l3, %o0
    1758:	c4 58 60 00 	ldx  [ %g1 ], %g2
    175c:	c2 58 80 00 	ldx  [ %g2 ], %g1
    1760:	9f c0 40 00 	call  %g1
    1764:	92 10 00 18 	mov  %i0, %o1
    1768:	ce 5c 60 48 	ldx  [ %l1 + 0x48 ], %g7
    176c:	c2 59 e0 38 	ldx  [ %g7 + 0x38 ], %g1
    1770:	2a f8 7f b2 	brnz,a   %g1, 1638 <usb_hcd_submit_urb+0x58>
    1774:	c2 5c 60 50 	ldx  [ %l1 + 0x50 ], %g1
    1778:	c2 5c 60 50 	ldx  [ %l1 + 0x50 ], %g1
    177c:	c4 08 60 03 	ldub  [ %g1 + 3 ], %g2
    1780:	84 08 a0 03 	and  %g2, 3, %g2
    1784:	80 a0 a0 03 	cmp  %g2, 3
    1788:	32 40 00 98 	bne,a,pn   %icc, 19e8 <usb_hcd_submit_urb+0x408>
    178c:	80 a0 a0 00 	cmp  %g2, 0
    1790:	c4 01 e4 20 	ld  [ %g7 + 0x420 ], %g2
    1794:	a1 52 00 00 	rdpr  %pil, %l0
    1798:	91 90 20 0f 	wrpr  0xf, %pil
    179c:	c2 5c e0 d0 	ldx  [ %l3 + 0xd0 ], %g1
    17a0:	02 c0 40 5d 	brz,pn   %g1, 1914 <usb_hcd_submit_urb+0x334>
    17a4:	80 a0 a0 00 	cmp  %g2, 0
    17a8:	a4 10 3f ea 	mov  -22, %l2
    17ac:	02 cc 00 39 	brz  %l0, 1890 <usb_hcd_submit_urb+0x2b0>
    17b0:	82 10 20 00 	clr  %g1
    17b4:	91 94 00 00 	wrpr  %l0, %pil
    17b8:	10 6f ff ba 	b  %xcc, 16a0 <usb_hcd_submit_urb+0xc0>
    17bc:	80 a4 a0 00 	cmp  %l2, 0
    17c0:	32 6f ff ae 	bne,a   %xcc, 1678 <usb_hcd_submit_urb+0x98>
    17c4:	ce 5c 60 48 	ldx  [ %l1 + 0x48 ], %g7
    17c8:	c2 0c e0 18 	ldub  [ %l3 + 0x18 ], %g1
    17cc:	80 a0 60 00 	cmp  %g1, 0
    17d0:	12 40 00 7a 	bne,pn   %icc, 19b8 <usb_hcd_submit_urb+0x3d8>
    17d4:	03 00 00 00 	sethi  %hi(0), %g1
    17d8:	c2 5c e0 d8 	ldx  [ %l3 + 0xd8 ], %g1
    17dc:	c4 00 60 20 	ld  [ %g1 + 0x20 ], %g2
    17e0:	80 88 a0 02 	btst  2, %g2
    17e4:	22 6f ff a5 	be,a   %xcc, 1678 <usb_hcd_submit_urb+0x98>
    17e8:	ce 5c 60 48 	ldx  [ %l1 + 0x48 ], %g7
    17ec:	c2 5c 60 48 	ldx  [ %l1 + 0x48 ], %g1
    17f0:	b1 3a 60 00 	sra  %o1, 0, %i0
    17f4:	94 10 00 19 	mov  %i1, %o2
    17f8:	92 06 20 08 	add  %i0, 8, %o1
    17fc:	96 04 60 70 	add  %l1, 0x70, %o3
    1800:	40 00 00 00 	call  1800 <usb_hcd_submit_urb+0x220>
    1804:	d0 58 60 40 	ldx  [ %g1 + 0x40 ], %o0
    1808:	02 c2 01 0d 	brz,pn   %o0, 1c3c <usb_hcd_submit_urb+0x65c>
    180c:	a4 10 00 08 	mov  %o0, %l2
    1810:	c4 0c 60 68 	ldub  [ %l1 + 0x68 ], %g2
    1814:	86 02 00 18 	add  %o0, %i0, %g3
    1818:	80 a4 20 01 	cmp  %l0, 1
    181c:	c4 2a 00 18 	stb  %g2, [ %o0 + %i0 ]
    1820:	c2 0c 60 69 	ldub  [ %l1 + 0x69 ], %g1
    1824:	c2 28 e0 01 	stb  %g1, [ %g3 + 1 ]
    1828:	c4 0c 60 6a 	ldub  [ %l1 + 0x6a ], %g2
    182c:	c4 28 e0 02 	stb  %g2, [ %g3 + 2 ]
    1830:	c2 0c 60 6b 	ldub  [ %l1 + 0x6b ], %g1
    1834:	c2 28 e0 03 	stb  %g1, [ %g3 + 3 ]
    1838:	c4 0c 60 6c 	ldub  [ %l1 + 0x6c ], %g2
    183c:	c4 28 e0 04 	stb  %g2, [ %g3 + 4 ]
    1840:	c2 0c 60 6d 	ldub  [ %l1 + 0x6d ], %g1
    1844:	c2 28 e0 05 	stb  %g1, [ %g3 + 5 ]
    1848:	c4 0c 60 6e 	ldub  [ %l1 + 0x6e ], %g2
    184c:	c4 28 e0 06 	stb  %g2, [ %g3 + 6 ]
    1850:	c2 0c 60 6f 	ldub  [ %l1 + 0x6f ], %g1
    1854:	02 40 00 54 	be,pn   %icc, 19a4 <usb_hcd_submit_urb+0x3c4>
    1858:	c2 28 e0 07 	stb  %g1, [ %g3 + 7 ]
    185c:	10 6f ff 86 	b  %xcc, 1674 <usb_hcd_submit_urb+0x94>
    1860:	e4 74 60 68 	stx  %l2, [ %l1 + 0x68 ]
    1864:	d0 5c c0 00 	ldx  [ %l3 ], %o0
    1868:	94 10 20 08 	mov  8, %o2
    186c:	c4 58 60 00 	ldx  [ %g1 ], %g2
    1870:	96 10 20 01 	mov  1, %o3
    1874:	a4 10 20 00 	clr  %l2
    1878:	c2 58 a0 10 	ldx  [ %g2 + 0x10 ], %g1
    187c:	9f c0 40 00 	call  %g1
    1880:	d2 5c 60 80 	ldx  [ %l1 + 0x80 ], %o1
    1884:	d0 24 60 88 	st  %o0, [ %l1 + 0x88 ]
    1888:	10 6f ff 71 	b  %xcc, 164c <usb_hcd_submit_urb+0x6c>
    188c:	c6 04 60 60 	ld  [ %l1 + 0x60 ], %g3
    1890:	91 90 40 00 	wrpr  %g1, %pil
    1894:	10 6f ff 83 	b  %xcc, 16a0 <usb_hcd_submit_urb+0xc0>
    1898:	80 a4 a0 00 	cmp  %l2, 0
    189c:	d0 59 e0 40 	ldx  [ %g7 + 0x40 ], %o0
    18a0:	92 10 20 10 	mov  0x10, %o1
    18a4:	94 10 00 19 	mov  %i1, %o2
    18a8:	40 00 00 00 	call  18a8 <usb_hcd_submit_urb+0x2c8>
    18ac:	96 04 60 88 	add  %l1, 0x88, %o3
    18b0:	02 c2 00 4b 	brz,pn   %o0, 19dc <usb_hcd_submit_urb+0x3fc>
    18b4:	a0 10 00 08 	mov  %o0, %l0
    18b8:	c4 0c 60 80 	ldub  [ %l1 + 0x80 ], %g2
    18bc:	94 10 20 08 	mov  8, %o2
    18c0:	a4 10 20 00 	clr  %l2
    18c4:	c4 2a 20 08 	stb  %g2, [ %o0 + 8 ]
    18c8:	c2 0c 60 81 	ldub  [ %l1 + 0x81 ], %g1
    18cc:	c2 2a 20 09 	stb  %g1, [ %o0 + 9 ]
    18d0:	c4 0c 60 82 	ldub  [ %l1 + 0x82 ], %g2
    18d4:	c4 2a 20 0a 	stb  %g2, [ %o0 + 0xa ]
    18d8:	c2 0c 60 83 	ldub  [ %l1 + 0x83 ], %g1
    18dc:	c2 2a 20 0b 	stb  %g1, [ %o0 + 0xb ]
    18e0:	c4 0c 60 84 	ldub  [ %l1 + 0x84 ], %g2
    18e4:	c4 2a 20 0c 	stb  %g2, [ %o0 + 0xc ]
    18e8:	c2 0c 60 85 	ldub  [ %l1 + 0x85 ], %g1
    18ec:	c2 2a 20 0d 	stb  %g1, [ %o0 + 0xd ]
    18f0:	c4 0c 60 86 	ldub  [ %l1 + 0x86 ], %g2
    18f4:	c4 2a 20 0e 	stb  %g2, [ %o0 + 0xe ]
    18f8:	c2 0c 60 87 	ldub  [ %l1 + 0x87 ], %g1
    18fc:	c2 2a 20 0f 	stb  %g1, [ %o0 + 0xf ]
    1900:	40 00 00 00 	call  1900 <usb_hcd_submit_urb+0x320>
    1904:	d2 5c 60 80 	ldx  [ %l1 + 0x80 ], %o1
    1908:	c6 04 60 60 	ld  [ %l1 + 0x60 ], %g3
    190c:	10 6f ff 50 	b  %xcc, 164c <usb_hcd_submit_urb+0x6c>
    1910:	e0 74 60 80 	stx  %l0, [ %l1 + 0x80 ]
    1914:	82 00 a0 07 	add  %g2, 7, %g1
    1918:	c6 04 60 74 	ld  [ %l1 + 0x74 ], %g3
    191c:	85 64 c0 01 	movl  %icc, %g1, %g2
    1920:	85 38 a0 03 	sra  %g2, 3, %g2
    1924:	80 a0 80 03 	cmp  %g2, %g3
    1928:	16 4f ff a1 	bge  %icc, 17ac <usb_hcd_submit_urb+0x1cc>
    192c:	a4 10 3f ea 	mov  -22, %l2
    1930:	90 10 00 13 	mov  %l3, %o0
    1934:	40 00 00 00 	call  1934 <usb_hcd_submit_urb+0x354>
    1938:	92 10 00 11 	mov  %l1, %o1
    193c:	a4 92 20 00 	orcc  %o0, 0, %l2
    1940:	12 4f ff 9b 	bne  %icc, 17ac <usb_hcd_submit_urb+0x1cc>
    1944:	86 10 20 01 	mov  1, %g3
    1948:	e2 74 e0 d0 	stx  %l1, [ %l3 + 0xd0 ]
    194c:	e6 74 60 08 	stx  %l3, [ %l1 + 8 ]
    1950:	83 28 f0 3e 	sllx  %g3, 0x3e, %g1
    1954:	c4 5c e0 e8 	ldx  [ %l3 + 0xe8 ], %g2
    1958:	82 08 80 01 	and  %g2, %g1, %g1
    195c:	02 c0 40 de 	brz,pn   %g1, 1cd4 <usb_hcd_submit_urb+0x6f4>
    1960:	83 28 f0 3c 	sllx  %g3, 0x3c, %g1
    1964:	82 08 80 01 	and  %g2, %g1, %g1
    1968:	02 f8 7f 91 	brz  %g1, 17ac <usb_hcd_submit_urb+0x1cc>
    196c:	03 00 00 00 	sethi  %hi(0), %g1
    1970:	90 04 e0 a0 	add  %l3, 0xa0, %o0
    1974:	d2 58 60 00 	ldx  [ %g1 ], %o1
    1978:	40 00 00 00 	call  1978 <usb_hcd_submit_urb+0x398>
    197c:	01 00 00 00 	nop 
    1980:	10 6f ff 8b 	b  %xcc, 17ac <usb_hcd_submit_urb+0x1cc>
    1984:	01 00 00 00 	nop 
    1988:	92 10 20 03 	mov  3, %o1	! 3 <usb_calc_bus_time+0x3>
    198c:	90 12 20 00 	mov  %o0, %o0
    1990:	94 10 20 01 	mov  1, %o2
    1994:	40 00 00 00 	call  1994 <usb_hcd_submit_urb+0x3b4>
    1998:	96 10 20 00 	clr  %o3
    199c:	10 6f ff 6a 	b  %xcc, 1744 <usb_hcd_submit_urb+0x164>
    19a0:	01 00 00 00 	nop 
    19a4:	d2 5c 60 68 	ldx  [ %l1 + 0x68 ], %o1
    19a8:	40 00 00 00 	call  19a8 <usb_hcd_submit_urb+0x3c8>
    19ac:	94 10 00 18 	mov  %i0, %o2
    19b0:	10 6f ff 31 	b  %xcc, 1674 <usb_hcd_submit_urb+0x94>
    19b4:	e4 74 60 68 	stx  %l2, [ %l1 + 0x68 ]
    19b8:	95 3a 60 00 	sra  %o1, 0, %o2
    19bc:	d0 5c c0 00 	ldx  [ %l3 ], %o0
    19c0:	c4 58 60 00 	ldx  [ %g1 ], %g2
    19c4:	96 0c 20 03 	and  %l0, 3, %o3
    19c8:	c2 58 a0 10 	ldx  [ %g2 + 0x10 ], %g1
    19cc:	9f c0 40 00 	call  %g1
    19d0:	d2 5c 60 68 	ldx  [ %l1 + 0x68 ], %o1
    19d4:	10 6f ff 28 	b  %xcc, 1674 <usb_hcd_submit_urb+0x94>
    19d8:	d0 24 60 70 	st  %o0, [ %l1 + 0x70 ]
    19dc:	c6 04 60 60 	ld  [ %l1 + 0x60 ], %g3
    19e0:	10 6f ff 1b 	b  %xcc, 164c <usb_hcd_submit_urb+0x6c>
    19e4:	a4 10 3f f4 	mov  -12, %l2
    19e8:	02 40 00 0b 	be,pn   %icc, 1a14 <usb_hcd_submit_urb+0x434>
    19ec:	a4 10 3f ea 	mov  -22, %l2
    19f0:	c2 04 e0 70 	ld  [ %l3 + 0x70 ], %g1
    19f4:	80 a0 60 00 	cmp  %g1, 0
    19f8:	12 40 00 ae 	bne,pn   %icc, 1cb0 <usb_hcd_submit_urb+0x6d0>
    19fc:	b1 3c a0 00 	sra  %l2, 0, %i0
    1a00:	90 10 00 13 	mov  %l3, %o0
    1a04:	7f ff fc 0f 	call  a40 <unmap_urb_for_dma>
    1a08:	92 10 00 11 	mov  %l1, %o1
    1a0c:	10 6f ff 40 	b  %xcc, 170c <usb_hcd_submit_urb+0x12c>
    1a10:	82 04 60 20 	add  %l1, 0x20, %g1
    1a14:	ea 5c 60 68 	ldx  [ %l1 + 0x68 ], %l5
    1a18:	91 90 20 0f 	wrpr  0xf, %pil
    1a1c:	90 10 00 13 	mov  %l3, %o0
    1a20:	40 00 00 00 	call  1a20 <usb_hcd_submit_urb+0x440>
    1a24:	92 10 00 11 	mov  %l1, %o1
    1a28:	a4 10 00 08 	mov  %o0, %l2
    1a2c:	91 90 20 00 	wrpr  0, %pil
    1a30:	80 a2 20 00 	cmp  %o0, 0
    1a34:	32 4f ff f0 	bne,a   %icc, 19f4 <usb_hcd_submit_urb+0x414>
    1a38:	c2 04 e0 70 	ld  [ %l3 + 0x70 ], %g1
    1a3c:	c2 5c 60 80 	ldx  [ %l1 + 0x80 ], %g1
    1a40:	e6 74 60 08 	stx  %l3, [ %l1 + 8 ]
    1a44:	c4 08 60 06 	ldub  [ %g1 + 6 ], %g2
    1a48:	c6 08 60 07 	ldub  [ %g1 + 7 ], %g3
    1a4c:	d8 08 60 02 	ldub  [ %g1 + 2 ], %o4
    1a50:	85 28 b0 08 	sllx  %g2, 8, %g2
    1a54:	ce 08 60 03 	ldub  [ %g1 + 3 ], %g7
    1a58:	d6 08 60 04 	ldub  [ %g1 + 4 ], %o3
    1a5c:	86 10 c0 02 	or  %g3, %g2, %g3
    1a60:	da 08 60 05 	ldub  [ %g1 + 5 ], %o5
    1a64:	87 28 e0 10 	sll  %g3, 0x10, %g3
    1a68:	99 2b 30 08 	sllx  %o4, 8, %o4
    1a6c:	85 30 e0 18 	srl  %g3, 0x18, %g2
    1a70:	8e 11 c0 0c 	or  %g7, %o4, %g7
    1a74:	d0 08 40 00 	ldub  [ %g1 ], %o0
    1a78:	97 2a f0 08 	sllx  %o3, 8, %o3
    1a7c:	87 30 e0 08 	srl  %g3, 8, %g3
    1a80:	d2 08 60 01 	ldub  [ %g1 + 1 ], %o1
    1a84:	86 10 c0 02 	or  %g3, %g2, %g3
    1a88:	9a 13 40 0b 	or  %o5, %o3, %o5
    1a8c:	8f 29 e0 10 	sll  %g7, 0x10, %g7
    1a90:	9b 2b 60 10 	sll  %o5, 0x10, %o5
    1a94:	d8 04 60 74 	ld  [ %l1 + 0x74 ], %o4
    1a98:	83 31 e0 18 	srl  %g7, 0x18, %g1
    1a9c:	b3 28 e0 10 	sll  %g3, 0x10, %i1
    1aa0:	8f 31 e0 08 	srl  %g7, 8, %g7
    1aa4:	85 33 60 18 	srl  %o5, 0x18, %g2
    1aa8:	8e 11 c0 01 	or  %g7, %g1, %g7
    1aac:	9b 33 60 08 	srl  %o5, 8, %o5
    1ab0:	a1 36 60 10 	srl  %i1, 0x10, %l0
    1ab4:	96 13 40 02 	or  %o5, %g2, %o3
    1ab8:	80 a4 00 0c 	cmp  %l0, %o4
    1abc:	14 48 00 9f 	bg  %icc, 1d38 <usb_hcd_submit_urb+0x758>
    1ac0:	94 10 00 07 	mov  %g7, %o2
    1ac4:	82 0a 20 ff 	and  %o0, 0xff, %g1
    1ac8:	84 0a 60 ff 	and  %o1, 0xff, %g2
    1acc:	c0 24 60 78 	clr  [ %l1 + 0x78 ]
    1ad0:	83 28 60 08 	sll  %g1, 8, %g1
    1ad4:	82 10 40 02 	or  %g1, %g2, %g1
    1ad8:	9b 28 60 10 	sll  %g1, 0x10, %o5
    1adc:	99 33 60 10 	srl  %o5, 0x10, %o4
    1ae0:	80 a3 21 01 	cmp  %o4, 0x101
    1ae4:	02 40 00 af 	be,pn   %icc, 1da0 <usb_hcd_submit_urb+0x7c0>
    1ae8:	84 10 00 01 	mov  %g1, %g2
    1aec:	80 a3 21 01 	cmp  %o4, 0x101
    1af0:	38 48 00 94 	bgu,a   %icc, 1d40 <usb_hcd_submit_urb+0x760>
    1af4:	11 00 00 20 	sethi  %hi(0x8000), %o0
    1af8:	80 a3 20 05 	cmp  %o4, 5
    1afc:	22 40 00 aa 	be,a,pn   %icc, 1da4 <usb_hcd_submit_urb+0x7c4>
    1b00:	b2 10 20 00 	clr  %i1
    1b04:	18 48 00 a3 	bgu  %icc, 1d90 <usb_hcd_submit_urb+0x7b0>
    1b08:	80 a3 20 09 	cmp  %o4, 9
    1b0c:	80 a3 20 01 	cmp  %o4, 1
    1b10:	02 40 00 82 	be,pn   %icc, 1d18 <usb_hcd_submit_urb+0x738>
    1b14:	80 a3 20 03 	cmp  %o4, 3
    1b18:	22 40 00 7b 	be,a,pn   %icc, 1d04 <usb_hcd_submit_urb+0x724>
    1b1c:	c4 5c e0 30 	ldx  [ %l3 + 0x30 ], %g2
    1b20:	19 00 00 28 	sethi  %hi(0xa000), %o4
    1b24:	8f 33 60 10 	srl  %o5, 0x10, %g7
    1b28:	82 13 20 06 	or  %o4, 6, %g1
    1b2c:	80 a1 c0 01 	cmp  %g7, %g1
    1b30:	02 40 00 08 	be,pn   %icc, 1b50 <usb_hcd_submit_urb+0x570>
    1b34:	a0 10 20 0f 	mov  0xf, %l0
    1b38:	82 13 23 00 	or  %o4, 0x300, %g1
    1b3c:	80 a1 c0 01 	cmp  %g7, %g1
    1b40:	02 40 00 de 	be,pn   %icc, 1eb8 <usb_hcd_submit_urb+0x8d8>
    1b44:	80 a1 c0 0c 	cmp  %g7, %o4
    1b48:	02 40 00 dc 	be,pn   %icc, 1eb8 <usb_hcd_submit_urb+0x8d8>
    1b4c:	a0 10 20 00 	clr  %l0
    1b50:	c2 5c e0 d8 	ldx  [ %l3 + 0xd8 ], %g1
    1b54:	93 28 b0 30 	sllx  %g2, 0x30, %o1
    1b58:	9b 28 f0 30 	sllx  %g3, 0x30, %o5
    1b5c:	95 2a b0 30 	sllx  %o2, 0x30, %o2
    1b60:	97 2a f0 30 	sllx  %o3, 0x30, %o3
    1b64:	c4 58 60 80 	ldx  [ %g1 + 0x80 ], %g2
    1b68:	a8 07 a7 df 	add  %fp, 0x7df, %l4
    1b6c:	93 32 70 30 	srlx  %o1, 0x30, %o1
    1b70:	95 32 b0 30 	srlx  %o2, 0x30, %o2
    1b74:	97 32 f0 30 	srlx  %o3, 0x30, %o3
    1b78:	9b 33 70 30 	srlx  %o5, 0x30, %o5
    1b7c:	90 10 00 13 	mov  %l3, %o0
    1b80:	9f c0 80 00 	call  %g2
    1b84:	98 10 00 14 	mov  %l4, %o4
    1b88:	b0 92 20 00 	orcc  %o0, 0, %i0
    1b8c:	12 40 00 1c 	bne,pn   %icc, 1bfc <usb_hcd_submit_urb+0x61c>
    1b90:	92 10 00 14 	mov  %l4, %o1
    1b94:	b2 10 20 00 	clr  %i1
    1b98:	a8 10 20 00 	clr  %l4
    1b9c:	80 a4 20 00 	cmp  %l0, 0
    1ba0:	02 40 00 17 	be,pn   %icc, 1bfc <usb_hcd_submit_urb+0x61c>
    1ba4:	90 10 00 15 	mov  %l5, %o0
    1ba8:	c2 04 60 74 	ld  [ %l1 + 0x74 ], %g1
    1bac:	80 a4 00 01 	cmp  %l0, %g1
    1bb0:	a1 66 80 01 	movg  %icc, %g1, %l0
    1bb4:	e0 24 60 78 	st  %l0, [ %l1 + 0x78 ]
    1bb8:	40 00 00 00 	call  1bb8 <usb_hcd_submit_urb+0x5d8>
    1bbc:	95 3c 20 00 	sra  %l0, 0, %o2
    1bc0:	80 a4 20 07 	cmp  %l0, 7
    1bc4:	82 10 20 00 	clr  %g1
    1bc8:	83 67 20 01 	movgu  %icc, 1, %g1
    1bcc:	80 88 40 14 	btst  %g1, %l4
    1bd0:	02 48 00 05 	be  %icc, 1be4 <usb_hcd_submit_urb+0x604>
    1bd4:	80 a4 20 06 	cmp  %l0, 6
    1bd8:	c2 0d 60 07 	ldub  [ %l5 + 7 ], %g1
    1bdc:	82 10 60 20 	or  %g1, 0x20, %g1
    1be0:	c2 2d 60 07 	stb  %g1, [ %l5 + 7 ]
    1be4:	82 10 20 00 	clr  %g1
    1be8:	83 67 20 01 	movgu  %icc, 1, %g1
    1bec:	80 88 40 19 	btst  %g1, %i1
    1bf0:	02 48 00 03 	be  %icc, 1bfc <usb_hcd_submit_urb+0x61c>
    1bf4:	82 10 20 01 	mov  1, %g1
    1bf8:	c2 2d 60 06 	stb  %g1, [ %l5 + 6 ]
    1bfc:	91 90 20 0f 	wrpr  0xf, %pil
    1c00:	c2 5c 60 28 	ldx  [ %l1 + 0x28 ], %g1
    1c04:	86 04 60 20 	add  %l1, 0x20, %g3
    1c08:	90 10 00 13 	mov  %l3, %o0
    1c0c:	c4 5c 60 20 	ldx  [ %l1 + 0x20 ], %g2
    1c10:	92 10 00 11 	mov  %l1, %o1
    1c14:	95 3e 20 00 	sra  %i0, 0, %o2
    1c18:	c4 70 40 00 	stx  %g2, [ %g1 ]
    1c1c:	c2 70 a0 08 	stx  %g1, [ %g2 + 8 ]
    1c20:	c6 74 60 28 	stx  %g3, [ %l1 + 0x28 ]
    1c24:	40 00 00 00 	call  1c24 <usb_hcd_submit_urb+0x644>
    1c28:	c6 74 60 20 	stx  %g3, [ %l1 + 0x20 ]
    1c2c:	91 90 20 00 	wrpr  0, %pil
    1c30:	b1 3c a0 00 	sra  %l2, 0, %i0
    1c34:	81 cf e0 08 	rett  %i7 + 8
    1c38:	01 00 00 00 	nop 
    1c3c:	c2 5c 60 50 	ldx  [ %l1 + 0x50 ], %g1
    1c40:	c4 08 60 03 	ldub  [ %g1 + 3 ], %g2
    1c44:	80 88 a0 03 	btst  3, %g2
    1c48:	12 6f fe ac 	bne  %xcc, 16f8 <usb_hcd_submit_urb+0x118>
    1c4c:	a4 10 3f f4 	mov  -12, %l2
    1c50:	c2 04 60 60 	ld  [ %l1 + 0x60 ], %g1
    1c54:	80 88 60 08 	btst  8, %g1
    1c58:	22 60 00 04 	be,a,pn   %xcc, 1c68 <usb_hcd_submit_urb+0x688>
    1c5c:	c2 5c 60 48 	ldx  [ %l1 + 0x48 ], %g1
    1c60:	10 6f fe a7 	b  %xcc, 16fc <usb_hcd_submit_urb+0x11c>
    1c64:	c2 04 e0 70 	ld  [ %l3 + 0x70 ], %g1
    1c68:	92 04 60 88 	add  %l1, 0x88, %o1
    1c6c:	94 04 60 80 	add  %l1, 0x80, %o2
    1c70:	96 10 20 08 	mov  8, %o3
    1c74:	98 10 20 01 	mov  1, %o4
    1c78:	d0 58 60 40 	ldx  [ %g1 + 0x40 ], %o0
    1c7c:	7f ff fb 41 	call  980 <hcd_free_coherent>
    1c80:	a4 10 3f f4 	mov  -12, %l2
    1c84:	10 6f fe 9e 	b  %xcc, 16fc <usb_hcd_submit_urb+0x11c>
    1c88:	c2 04 e0 70 	ld  [ %l3 + 0x70 ], %g1
    1c8c:	03 00 00 00 	sethi  %hi(0), %g1
    1c90:	c4 58 60 00 	ldx  [ %g1 ], %g2
    1c94:	90 10 00 13 	mov  %l3, %o0
    1c98:	92 10 00 11 	mov  %l1, %o1
    1c9c:	c2 58 a0 08 	ldx  [ %g2 + 8 ], %g1
    1ca0:	9f c0 40 00 	call  %g1
    1ca4:	94 10 00 18 	mov  %i0, %o2
    1ca8:	10 6f fe 99 	b  %xcc, 170c <usb_hcd_submit_urb+0x12c>
    1cac:	82 04 60 20 	add  %l1, 0x20, %g1
    1cb0:	03 00 00 00 	sethi  %hi(0), %g1
    1cb4:	90 10 00 13 	mov  %l3, %o0
    1cb8:	c4 58 60 00 	ldx  [ %g1 ], %g2
    1cbc:	92 10 00 11 	mov  %l1, %o1
    1cc0:	c2 58 a0 08 	ldx  [ %g2 + 8 ], %g1
    1cc4:	9f c0 40 00 	call  %g1
    1cc8:	94 10 00 18 	mov  %i0, %o2
    1ccc:	10 6f ff 4e 	b  %xcc, 1a04 <usb_hcd_submit_urb+0x424>
    1cd0:	90 10 00 13 	mov  %l3, %o0
    1cd4:	03 00 00 00 	sethi  %hi(0), %g1
    1cd8:	90 04 e0 a0 	add  %l3, 0xa0, %o0
    1cdc:	d2 58 60 00 	ldx  [ %g1 ], %o1
    1ce0:	92 6a 60 19 	udivx  %o1, 0x19, %o1
    1ce4:	92 02 60 01 	inc  %o1
    1ce8:	85 2a 70 03 	sllx  %o1, 3, %g2
    1cec:	83 2a 70 05 	sllx  %o1, 5, %g1
    1cf0:	82 20 40 02 	sub  %g1, %g2, %g1
    1cf4:	40 00 00 00 	call  1cf4 <usb_hcd_submit_urb+0x714>
    1cf8:	92 00 40 09 	add  %g1, %o1, %o1
    1cfc:	10 6f fe ac 	b  %xcc, 17ac <usb_hcd_submit_urb+0x1cc>
    1d00:	01 00 00 00 	nop 
    1d04:	c2 58 a2 00 	ldx  [ %g2 + 0x200 ], %g1
    1d08:	83 30 70 1f 	srlx  %g1, 0x1f, %g1
    1d0c:	80 88 60 01 	btst  1, %g1
    1d10:	02 6f ff bb 	be  %xcc, 1bfc <usb_hcd_submit_urb+0x61c>
    1d14:	b0 10 3f e0 	mov  -32, %i0
    1d18:	83 29 e0 10 	sll  %g7, 0x10, %g1
    1d1c:	b2 10 20 00 	clr  %i1
    1d20:	83 30 60 10 	srl  %g1, 0x10, %g1
    1d24:	a8 10 20 00 	clr  %l4
    1d28:	80 a0 60 01 	cmp  %g1, 1
    1d2c:	a0 10 20 00 	clr  %l0
    1d30:	02 40 00 16 	be,pn   %icc, 1d88 <usb_hcd_submit_urb+0x7a8>
    1d34:	92 07 a7 df 	add  %fp, 0x7df, %o1
    1d38:	10 6f ff b1 	b  %xcc, 1bfc <usb_hcd_submit_urb+0x61c>
    1d3c:	b0 10 3f e0 	mov  -32, %i0
    1d40:	82 12 20 06 	or  %o0, 6, %g1
    1d44:	80 a3 00 01 	cmp  %o4, %g1
    1d48:	22 40 00 2e 	be,a,pn   %icc, 1e00 <usb_hcd_submit_urb+0x820>
    1d4c:	85 29 e0 10 	sll  %g7, 0x10, %g2
    1d50:	38 48 00 1a 	bgu,a   %icc, 1db8 <usb_hcd_submit_urb+0x7d8>
    1d54:	82 12 20 0a 	or  %o0, 0xa, %g1
    1d58:	80 a3 21 03 	cmp  %o4, 0x103
    1d5c:	02 40 00 11 	be,pn   %icc, 1da0 <usb_hcd_submit_urb+0x7c0>
    1d60:	80 a3 00 08 	cmp  %o4, %o0
    1d64:	12 4f ff 70 	bne  %icc, 1b24 <usb_hcd_submit_urb+0x544>
    1d68:	19 00 00 28 	sethi  %hi(0xa000), %o4
    1d6c:	82 10 20 01 	mov  1, %g1
    1d70:	c0 2f a7 e0 	clrb  [ %fp + 0x7e0 ]
    1d74:	b2 10 20 00 	clr  %i1
    1d78:	c2 2f a7 df 	stb  %g1, [ %fp + 0x7df ]
    1d7c:	a8 10 20 00 	clr  %l4
    1d80:	a0 10 20 02 	mov  2, %l0
    1d84:	92 07 a7 df 	add  %fp, 0x7df, %o1
    1d88:	10 6f ff 85 	b  %xcc, 1b9c <usb_hcd_submit_urb+0x5bc>
    1d8c:	b0 10 20 00 	clr  %i0
    1d90:	02 40 00 04 	be,pn   %icc, 1da0 <usb_hcd_submit_urb+0x7c0>
    1d94:	80 a3 20 0b 	cmp  %o4, 0xb
    1d98:	12 4f ff 63 	bne  %icc, 1b24 <usb_hcd_submit_urb+0x544>
    1d9c:	19 00 00 28 	sethi  %hi(0xa000), %o4
    1da0:	b2 10 20 00 	clr  %i1
    1da4:	a8 10 20 00 	clr  %l4
    1da8:	a0 10 20 00 	clr  %l0
    1dac:	92 07 a7 df 	add  %fp, 0x7df, %o1
    1db0:	10 6f ff 7b 	b  %xcc, 1b9c <usb_hcd_submit_urb+0x5bc>
    1db4:	b0 10 20 00 	clr  %i0
    1db8:	80 a3 00 01 	cmp  %o4, %g1
    1dbc:	02 40 00 38 	be,pn   %icc, 1e9c <usb_hcd_submit_urb+0x8bc>
    1dc0:	82 12 21 00 	or  %o0, 0x100, %g1
    1dc4:	80 a3 00 01 	cmp  %o4, %g1
    1dc8:	02 40 00 2d 	be,pn   %icc, 1e7c <usb_hcd_submit_urb+0x89c>
    1dcc:	03 00 00 20 	sethi  %hi(0x8000), %g1
    1dd0:	82 10 60 08 	or  %g1, 8, %g1	! 8008 <usb_host_init+0x5f08>
    1dd4:	80 a3 00 01 	cmp  %o4, %g1
    1dd8:	12 4f ff 53 	bne  %icc, 1b24 <usb_hcd_submit_urb+0x544>
    1ddc:	19 00 00 28 	sethi  %hi(0xa000), %o4
    1de0:	82 10 20 01 	mov  1, %g1
    1de4:	b2 10 20 00 	clr  %i1
    1de8:	c2 2f a7 df 	stb  %g1, [ %fp + 0x7df ]
    1dec:	a8 10 20 00 	clr  %l4
    1df0:	a0 10 20 01 	mov  1, %l0
    1df4:	92 07 a7 df 	add  %fp, 0x7df, %o1
    1df8:	10 6f ff 69 	b  %xcc, 1b9c <usb_hcd_submit_urb+0x5bc>
    1dfc:	b0 10 20 00 	clr  %i0
    1e00:	03 00 00 3f 	sethi  %hi(0xfc00), %g1
    1e04:	85 30 a0 10 	srl  %g2, 0x10, %g2
    1e08:	82 10 63 00 	or  %g1, 0x300, %g1
    1e0c:	82 08 80 01 	and  %g2, %g1, %g1
    1e10:	80 a0 62 00 	cmp  %g1, 0x200
    1e14:	02 40 00 72 	be,pn   %icc, 1fdc <usb_hcd_submit_urb+0x9fc>
    1e18:	80 a0 63 00 	cmp  %g1, 0x300
    1e1c:	02 40 00 29 	be,pn   %icc, 1ec0 <usb_hcd_submit_urb+0x8e0>
    1e20:	80 a0 61 00 	cmp  %g1, 0x100
    1e24:	12 4f ff 76 	bne  %icc, 1bfc <usb_hcd_submit_urb+0x61c>
    1e28:	b0 10 3f e0 	mov  -32, %i0
    1e2c:	c4 5c e0 d8 	ldx  [ %l3 + 0xd8 ], %g2
    1e30:	03 00 00 00 	sethi  %hi(0), %g1
    1e34:	92 10 60 00 	mov  %g1, %o1	! 0 <usb_calc_bus_time>
    1e38:	c2 00 a0 20 	ld  [ %g2 + 0x20 ], %g1
    1e3c:	80 88 60 20 	btst  0x20, %g1
    1e40:	32 68 00 07 	bne,a   %xcc, 1e5c <usb_hcd_submit_urb+0x87c>
    1e44:	c2 5c e0 e8 	ldx  [ %l3 + 0xe8 ], %g1
    1e48:	80 88 60 10 	btst  0x10, %g1
    1e4c:	02 6f ff 6c 	be  %xcc, 1bfc <usb_hcd_submit_urb+0x61c>
    1e50:	03 00 00 00 	sethi  %hi(0), %g1
    1e54:	92 10 60 00 	mov  %g1, %o1	! 0 <usb_calc_bus_time>
    1e58:	c2 5c e0 e8 	ldx  [ %l3 + 0xe8 ], %g1
    1e5c:	b2 10 20 01 	mov  1, %i1
    1e60:	a8 10 20 00 	clr  %l4
    1e64:	a0 10 20 12 	mov  0x12, %l0
    1e68:	b0 10 20 00 	clr  %i0
    1e6c:	83 30 70 39 	srlx  %g1, 0x39, %g1
    1e70:	82 08 60 01 	and  %g1, 1, %g1
    1e74:	10 6f ff 4a 	b  %xcc, 1b9c <usb_hcd_submit_urb+0x5bc>
    1e78:	b3 78 44 00 	movre  %g1, %g0, %i1
    1e7c:	c0 2f a7 df 	clrb  [ %fp + 0x7df ]
    1e80:	b2 10 20 00 	clr  %i1
    1e84:	a8 10 20 00 	clr  %l4
    1e88:	c0 2f a7 e0 	clrb  [ %fp + 0x7e0 ]
    1e8c:	a0 10 20 02 	mov  2, %l0
    1e90:	92 07 a7 df 	add  %fp, 0x7df, %o1
    1e94:	10 6f ff 42 	b  %xcc, 1b9c <usb_hcd_submit_urb+0x5bc>
    1e98:	b0 10 20 00 	clr  %i0
    1e9c:	c0 2f a7 df 	clrb  [ %fp + 0x7df ]
    1ea0:	b2 10 20 00 	clr  %i1
    1ea4:	a8 10 20 00 	clr  %l4
    1ea8:	a0 10 20 01 	mov  1, %l0
    1eac:	92 07 a7 df 	add  %fp, 0x7df, %o1
    1eb0:	10 6f ff 3b 	b  %xcc, 1b9c <usb_hcd_submit_urb+0x5bc>
    1eb4:	b0 10 20 00 	clr  %i0
    1eb8:	10 6f ff 26 	b  %xcc, 1b50 <usb_hcd_submit_urb+0x570>
    1ebc:	a0 10 20 04 	mov  4, %l0
    1ec0:	82 88 a0 ff 	andcc  %g2, 0xff, %g1
    1ec4:	02 40 00 6f 	be,pn   %icc, 2080 <usb_hcd_submit_urb+0xaa0>
    1ec8:	80 a0 60 01 	cmp  %g1, 1
    1ecc:	02 40 00 66 	be,pn   %icc, 2064 <usb_hcd_submit_urb+0xa84>
    1ed0:	80 a0 60 02 	cmp  %g1, 2
    1ed4:	12 40 00 54 	bne,pn   %icc, 2024 <usb_hcd_submit_urb+0xa44>
    1ed8:	a8 07 a7 77 	add  %fp, 0x777, %l4
    1edc:	d2 5c e0 80 	ldx  [ %l3 + 0x80 ], %o1
    1ee0:	94 10 20 64 	mov  0x64, %o2
    1ee4:	40 00 00 00 	call  1ee4 <usb_hcd_submit_urb+0x904>
    1ee8:	90 10 00 14 	mov  %l4, %o0
    1eec:	87 36 60 10 	srl  %i1, 0x10, %g3
    1ef0:	80 a0 e0 01 	cmp  %g3, 1
    1ef4:	22 40 00 2e 	be,a,pn   %icc, 1fac <usb_hcd_submit_urb+0x9cc>
    1ef8:	a0 10 20 01 	mov  1, %l0
    1efc:	2a 48 00 32 	bcs,a   %icc, 1fc4 <usb_hcd_submit_urb+0x9e4>
    1f00:	e0 24 60 78 	st  %l0, [ %l1 + 0x78 ]
    1f04:	80 a0 e0 02 	cmp  %g3, 2
    1f08:	02 40 00 45 	be,pn   %icc, 201c <usb_hcd_submit_urb+0xa3c>
    1f0c:	ce 0f a7 77 	ldub  [ %fp + 0x777 ], %g7
    1f10:	9a 04 3f fe 	add  %l0, -2, %o5
    1f14:	98 05 60 02 	add  %l5, 2, %o4
    1f18:	92 10 00 14 	mov  %l4, %o1
    1f1c:	96 10 20 00 	clr  %o3
    1f20:	83 29 e0 18 	sll  %g7, 0x18, %g1
    1f24:	80 a0 00 01 	cmp  %g0, %g1
    1f28:	82 10 20 00 	clr  %g1
    1f2c:	84 40 20 00 	addc  %g0, 0, %g2
    1f30:	80 a3 60 01 	cmp  %o5, 1
    1f34:	83 66 a0 01 	movg  %icc, 1, %g1
    1f38:	80 88 80 01 	btst  %g2, %g1
    1f3c:	02 40 00 14 	be,pn   %icc, 1f8c <usb_hcd_submit_urb+0x9ac>
    1f40:	94 10 20 00 	clr  %o2
    1f44:	94 00 ff fe 	add  %g3, -2, %o2
    1f48:	ce 2b 00 00 	stb  %g7, [ %o4 ]
    1f4c:	92 02 60 01 	inc  %o1
    1f50:	96 02 e0 02 	add  %o3, 2, %o3
    1f54:	c0 2b 20 01 	clrb  [ %o4 + 1 ]
    1f58:	86 22 80 0b 	sub  %o2, %o3, %g3
    1f5c:	98 03 20 02 	add  %o4, 2, %o4
    1f60:	ce 0a 40 00 	ldub  [ %o1 ], %g7
    1f64:	83 29 e0 18 	sll  %g7, 0x18, %g1
    1f68:	80 a0 00 01 	cmp  %g0, %g1
    1f6c:	82 10 20 00 	clr  %g1
    1f70:	84 40 20 00 	addc  %g0, 0, %g2
    1f74:	80 a0 e0 01 	cmp  %g3, 1
    1f78:	83 66 a0 01 	movg  %icc, 1, %g1
    1f7c:	80 88 80 01 	btst  %g2, %g1
    1f80:	12 4f ff f2 	bne  %icc, 1f48 <usb_hcd_submit_urb+0x968>
    1f84:	9a 03 7f fe 	add  %o5, -2, %o5
    1f88:	94 10 00 0b 	mov  %o3, %o2
    1f8c:	80 a3 60 00 	cmp  %o5, 0
    1f90:	24 40 00 05 	ble,a,pn   %icc, 1fa4 <usb_hcd_submit_urb+0x9c4>
    1f94:	a0 02 a0 02 	add  %o2, 2, %l0
    1f98:	ce 2b 00 00 	stb  %g7, [ %o4 ]
    1f9c:	94 02 e0 01 	add  %o3, 1, %o2
    1fa0:	a0 02 a0 02 	add  %o2, 2, %l0
    1fa4:	82 10 20 03 	mov  3, %g1
    1fa8:	c2 2d 60 01 	stb  %g1, [ %l5 + 1 ]
    1fac:	40 00 00 00 	call  1fac <usb_hcd_submit_urb+0x9cc>
    1fb0:	90 10 00 14 	mov  %l4, %o0
    1fb4:	90 02 20 01 	inc  %o0
    1fb8:	91 2a 30 01 	sllx  %o0, 1, %o0
    1fbc:	d0 2d 40 00 	stb  %o0, [ %l5 ]
    1fc0:	e0 24 60 78 	st  %l0, [ %l1 + 0x78 ]
    1fc4:	b2 10 20 00 	clr  %i1
    1fc8:	a8 10 20 00 	clr  %l4
    1fcc:	a0 10 20 00 	clr  %l0
    1fd0:	92 07 a7 df 	add  %fp, 0x7df, %o1
    1fd4:	10 6f fe f2 	b  %xcc, 1b9c <usb_hcd_submit_urb+0x5bc>
    1fd8:	b0 10 20 00 	clr  %i0
    1fdc:	c2 5c e0 d8 	ldx  [ %l3 + 0xd8 ], %g1
    1fe0:	05 00 00 00 	sethi  %hi(0), %g2
    1fe4:	c6 00 60 20 	ld  [ %g1 + 0x20 ], %g3
    1fe8:	80 88 e0 20 	btst  0x20, %g3
    1fec:	12 68 00 04 	bne  %xcc, 1ffc <usb_hcd_submit_urb+0xa1c>
    1ff0:	92 10 a0 00 	mov  %g2, %o1
    1ff4:	03 00 00 00 	sethi  %hi(0), %g1
    1ff8:	92 10 60 00 	mov  %g1, %o1	! 0 <usb_calc_bus_time>
    1ffc:	c4 5c e0 30 	ldx  [ %l3 + 0x30 ], %g2
    2000:	b2 10 20 00 	clr  %i1
    2004:	a0 10 20 19 	mov  0x19, %l0
    2008:	b0 10 20 00 	clr  %i0
    200c:	c2 58 a2 00 	ldx  [ %g2 + 0x200 ], %g1
    2010:	83 30 70 1f 	srlx  %g1, 0x1f, %g1
    2014:	10 6f fe e2 	b  %xcc, 1b9c <usb_hcd_submit_urb+0x5bc>
    2018:	a8 08 60 01 	and  %g1, 1, %l4
    201c:	10 6f ff e2 	b  %xcc, 1fa4 <usb_hcd_submit_urb+0x9c4>
    2020:	a0 10 20 02 	mov  2, %l0
    2024:	80 a0 60 03 	cmp  %g1, 3
    2028:	12 4f fe f5 	bne  %icc, 1bfc <usb_hcd_submit_urb+0x61c>
    202c:	b0 10 3f e0 	mov  -32, %i0
    2030:	c2 5c e0 d8 	ldx  [ %l3 + 0xd8 ], %g1
    2034:	17 00 00 00 	sethi  %hi(0), %o3
    2038:	a8 07 a7 77 	add  %fp, 0x777, %l4
    203c:	96 12 e0 00 	mov  %o3, %o3
    2040:	15 00 00 00 	sethi  %hi(0), %o2
    2044:	da 58 40 00 	ldx  [ %g1 ], %o5
    2048:	94 12 a0 00 	mov  %o2, %o2
    204c:	90 10 00 14 	mov  %l4, %o0
    2050:	92 10 20 64 	mov  0x64, %o1
    2054:	40 00 00 00 	call  2054 <usb_hcd_submit_urb+0xa74>
    2058:	98 02 e0 82 	add  %o3, 0x82, %o4
    205c:	10 6f ff a5 	b  %xcc, 1ef0 <usb_hcd_submit_urb+0x910>
    2060:	87 36 60 10 	srl  %i1, 0x10, %g3
    2064:	a8 07 a7 77 	add  %fp, 0x777, %l4
    2068:	d2 5c e0 10 	ldx  [ %l3 + 0x10 ], %o1
    206c:	94 10 20 64 	mov  0x64, %o2
    2070:	40 00 00 00 	call  2070 <usb_hcd_submit_urb+0xa90>
    2074:	90 10 00 14 	mov  %l4, %o0
    2078:	10 6f ff 9e 	b  %xcc, 1ef0 <usb_hcd_submit_urb+0x910>
    207c:	87 36 60 10 	srl  %i1, 0x10, %g3
    2080:	80 a4 20 04 	cmp  %l0, 4
    2084:	82 10 20 04 	mov  4, %g1
    2088:	c2 2f a7 7a 	stb  %g1, [ %fp + 0x77a ]
    208c:	a1 66 a0 04 	movg  %icc, 4, %l0
    2090:	84 10 20 03 	mov  3, %g2
    2094:	86 10 20 09 	mov  9, %g3
    2098:	90 10 00 15 	mov  %l5, %o0
    209c:	92 07 a7 77 	add  %fp, 0x777, %o1
    20a0:	c4 2f a7 78 	stb  %g2, [ %fp + 0x778 ]
    20a4:	95 3c 20 00 	sra  %l0, 0, %o2
    20a8:	c6 2f a7 79 	stb  %g3, [ %fp + 0x779 ]
    20ac:	40 00 00 00 	call  20ac <usb_hcd_submit_urb+0xacc>
    20b0:	c2 2f a7 77 	stb  %g1, [ %fp + 0x777 ]
    20b4:	80 a4 20 00 	cmp  %l0, 0
    20b8:	36 4f ff c3 	bge,a   %icc, 1fc4 <usb_hcd_submit_urb+0x9e4>
    20bc:	e0 24 60 78 	st  %l0, [ %l1 + 0x78 ]
    20c0:	10 6f fe cf 	b  %xcc, 1bfc <usb_hcd_submit_urb+0x61c>
    20c4:	b0 10 3f e0 	mov  -32, %i0
    20c8:	30 68 00 06 	b,a   %xcc, 20e0 <usb_host_cleanup>
    20cc:	01 00 00 00 	nop 
    20d0:	01 00 00 00 	nop 
    20d4:	01 00 00 00 	nop 
    20d8:	01 00 00 00 	nop 
    20dc:	01 00 00 00 	nop 

00000000000020e0 <usb_host_cleanup>:
    20e0:	03 00 00 00 	sethi  %hi(0), %g1
    20e4:	d0 58 60 00 	ldx  [ %g1 ], %o0
    20e8:	82 13 c0 00 	mov  %o7, %g1
    20ec:	40 00 00 00 	call  20ec <usb_host_cleanup+0xc>
    20f0:	9e 10 40 00 	mov  %g1, %o7
    20f4:	01 00 00 00 	nop 
    20f8:	01 00 00 00 	nop 
    20fc:	01 00 00 00 	nop 

0000000000002100 <usb_host_init>:
    2100:	9d e3 bf 40 	save  %sp, -192, %sp
    2104:	11 00 00 00 	sethi  %hi(0), %o0
    2108:	13 00 00 00 	sethi  %hi(0), %o1
    210c:	92 12 60 00 	mov  %o1, %o1	! 0 <usb_calc_bus_time>
    2110:	40 00 00 00 	call  2110 <usb_host_init+0x10>
    2114:	90 12 20 00 	mov  %o0, %o0
    2118:	80 a2 30 00 	cmp  %o0, -4096
    211c:	03 00 00 00 	sethi  %hi(0), %g1
    2120:	d0 70 60 00 	stx  %o0, [ %g1 ]
    2124:	91 65 30 00 	movleu  %xcc, 0, %o0
    2128:	b1 3a 20 00 	sra  %o0, 0, %i0
    212c:	81 cf e0 08 	rett  %i7 + 8
    2130:	01 00 00 00 	nop 
    2134:	30 68 00 03 	b,a   %xcc, 2140 <usb_host_init+0x40>
    2138:	01 00 00 00 	nop 
    213c:	01 00 00 00 	nop 

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
