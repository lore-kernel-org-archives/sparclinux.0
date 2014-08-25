From: Meelis Roos <mroos@linux.ee>
Date: Mon, 25 Aug 2014 13:14:11 +0000
Subject: Re: problem booting kernel compiled with gcc-4.9
Message-Id: <alpine.LRH.2.11.1408251602001.27437@siim2.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1406261446590.16879@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1406261446590.16879@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I noticed that gcc 4.9.0 for sparc has landed on Debian unstable so I 
> gave it a try on V210. Does not boot with strange error about user 
> windows. This is reproducible. Since the same kernel comiled with gcc 
> 4.6 booted fine, it's probably a gcc 4.9 difference.

I have done some more testing and digging.

About tests - 4.9 is problematic only on my UltraSparc IIIi machines 
(V210 and V440). US I not tested yet, all US II variants work fine in my 
servers. V480 with ful US III crashes with FATAL exception in different 
point of startup so I do not know about it.

> [   54.571516] CPU: 1 PID: 1 Comm: init Not tainted 3.16.0-rc2-00211-gd7933ab #96
> [   54.666431] Call Trace:
> [   54.698453]  [0000000000762f8c] panic+0xb0/0x224
> [   54.759071]  [000000000045cf68] do_exit+0x948/0x960
> [   54.823123]  [000000000042cbc0] fault_in_user_windows+0xe0/0x100
> [   54.902036]  [0000000000404ad0] __handle_user_windows+0x0/0x10
> [   54.978662] Press Stop-A (L1-A) to return to the boot prom
> [   55.050713] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

This is always the same.

Below are the disassemblies of fault_in_user_windows from 4.6.4 and 
4.9.0.

From gcc 4.6:

000000000042cac0 <fault_in_user_windows>:
  42cac0:	9d e3 bf 50 	save  %sp, -176, %sp
  42cac4:	7f ff 65 e7 	call  406260 <__flushw_user>
  42cac8:	b0 10 00 06 	mov  %g6, %i0
  42cacc:	f8 09 a0 0d 	ldub  [ %g6 + 0xd ], %i4
  42cad0:	02 c7 00 29 	brz,pn   %i4, 42cb74 <fault_in_user_windows+0xb4>
  42cad4:	82 10 00 06 	mov  %g6, %g1
  42cad8:	b6 07 20 77 	add  %i4, 0x77, %i3
  42cadc:	b8 07 3f ff 	add  %i4, -1, %i4
  42cae0:	c2 58 60 08 	ldx  [ %g1 + 8 ], %g1
  42cae4:	b7 2e f0 03 	sllx  %i3, 3, %i3
  42cae8:	b3 2f 30 07 	sllx  %i4, 7, %i1
  42caec:	b6 06 00 1b 	add  %i0, %i3, %i3
  42caf0:	b2 06 00 19 	add  %i0, %i1, %i1
  42caf4:	b6 06 e0 08 	add  %i3, 8, %i3
  42caf8:	b2 06 60 48 	add  %i1, 0x48, %i1
  42cafc:	82 08 60 80 	and  %g1, 0x80, %g1
  42cb00:	02 c8 40 19 	brz  %g1, 42cb64 <fault_in_user_windows+0xa4>
  42cb04:	fa 5e c0 00 	ldx  [ %i3 ], %i5
  42cb08:	82 0f 60 01 	and  %i5, 1, %g1
  42cb0c:	0a c8 40 16 	brnz  %g1, 42cb64 <fault_in_user_windows+0xa4>
  42cb10:	b4 10 20 40 	mov  0x40, %i2
  42cb14:	82 0f 60 07 	and  %i5, 7, %g1
  42cb18:	0a c0 40 22 	brnz,pn   %g1, 42cba0 <fault_in_user_windows+0xe0>
  42cb1c:	01 00 00 00 	nop 
  42cb20:	90 10 00 1d 	mov  %i5, %o0
  42cb24:	92 10 00 19 	mov  %i1, %o1
  42cb28:	40 07 63 56 	call  605880 <___copy_to_user>
  42cb2c:	94 10 00 1a 	mov  %i2, %o2
  42cb30:	0a c2 00 14 	brnz,pn   %o0, 42cb80 <fault_in_user_windows+0xc0>
  42cb34:	90 10 00 1d 	mov  %i5, %o0
  42cb38:	02 c7 00 0e 	brz,pn   %i4, 42cb70 <fault_in_user_windows+0xb0>
  42cb3c:	b6 06 ff f8 	add  %i3, -8, %i3
  42cb40:	b8 07 3f ff 	add  %i4, -1, %i4
  42cb44:	82 10 00 06 	mov  %g6, %g1
  42cb48:	fa 5e c0 00 	ldx  [ %i3 ], %i5
  42cb4c:	b3 2f 30 07 	sllx  %i4, 7, %i1
  42cb50:	c2 58 60 08 	ldx  [ %g1 + 8 ], %g1
  42cb54:	b2 06 00 19 	add  %i0, %i1, %i1
  42cb58:	82 08 60 80 	and  %g1, 0x80, %g1
  42cb5c:	0a f8 7f eb 	brnz  %g1, 42cb08 <fault_in_user_windows+0x48>
  42cb60:	b2 06 60 48 	add  %i1, 0x48, %i1
  42cb64:	ba 07 67 ff 	add  %i5, 0x7ff, %i5
  42cb68:	10 6f ff eb 	b  %xcc, 42cb14 <fault_in_user_windows+0x54>
  42cb6c:	b4 10 20 80 	mov  0x80, %i2
  42cb70:	82 10 00 06 	mov  %g6, %g1
  42cb74:	c0 28 60 0d 	clrb  [ %g1 + 0xd ]
  42cb78:	81 cf e0 08 	rett  %i7 + 8
  42cb7c:	01 00 00 00 	nop 
  42cb80:	92 10 00 19 	mov  %i1, %o1
  42cb84:	40 07 71 7f 	call  609180 <copy_to_user_fixup>
  42cb88:	94 10 00 1a 	mov  %i2, %o2
  42cb8c:	02 f2 3f eb 	brz,pn   %o0, 42cb38 <fault_in_user_windows+0x78>
  42cb90:	90 10 20 04 	mov  4, %o0
  42cb94:	b8 07 20 01 	inc  %i4
  42cb98:	40 00 bf d2 	call  45cae0 <do_exit>
  42cb9c:	f8 29 a0 0d 	stb  %i4, [ %g6 + 0xd ]
  42cba0:	7f ff fd b0 	call  42c260 <stack_unaligned>
  42cba4:	90 10 00 1d 	mov  %i5, %o0
  42cba8:	10 6f ff df 	b  %xcc, 42cb24 <fault_in_user_windows+0x64>
  42cbac:	90 10 00 1d 	mov  %i5, %o0
  42cbb0:	30 68 00 04 	b,a   %xcc, 42cbc0 <sparc_do_fork>
  42cbb4:	01 00 00 00 	nop 
  42cbb8:	01 00 00 00 	nop 
  42cbbc:	01 00 00 00 	nop 


From gcc 4.9:

000000000042cae0 <fault_in_user_windows>:
  42cae0:	9d e3 bf 50 	save  %sp, -176, %sp
  42cae4:	7f ff 65 df 	call  406260 <__flushw_user>
  42cae8:	b6 10 00 06 	mov  %g6, %i3
  42caec:	f8 09 a0 0d 	ldub  [ %g6 + 0xd ], %i4
  42caf0:	83 2f 30 07 	sllx  %i4, 7, %g1
  42caf4:	84 10 00 1c 	mov  %i4, %g2
  42caf8:	82 00 7f c8 	add  %g1, -56, %g1
  42cafc:	b9 2f 30 03 	sllx  %i4, 3, %i4
  42cb00:	b8 06 c0 1c 	add  %i3, %i4, %i4
  42cb04:	b4 00 bf ff 	add  %g2, -1, %i2
  42cb08:	02 c0 80 30 	brz,pn   %g2, 42cbc8 <fault_in_user_windows+0xe8>
  42cb0c:	b6 06 c0 01 	add  %i3, %g1, %i3
  42cb10:	c2 59 a0 08 	ldx  [ %g6 + 8 ], %g1
  42cb14:	82 08 60 80 	and  %g1, 0x80, %g1
  42cb18:	02 c8 40 17 	brz  %g1, 42cb74 <fault_in_user_windows+0x94>
  42cb1c:	fa 5f 23 c0 	ldx  [ %i4 + 0x3c0 ], %i5
  42cb20:	82 0f 60 01 	and  %i5, 1, %g1
  42cb24:	0a c8 40 14 	brnz  %g1, 42cb74 <fault_in_user_windows+0x94>
  42cb28:	b2 10 20 40 	mov  0x40, %i1
  42cb2c:	82 0f 60 07 	and  %i5, 7, %g1
  42cb30:	0a c0 40 15 	brnz,pn   %g1, 42cb84 <fault_in_user_windows+0xa4>
  42cb34:	01 00 00 00 	nop 
  42cb38:	90 10 00 1d 	mov  %i5, %o0
  42cb3c:	92 10 00 1b 	mov  %i3, %o1
  42cb40:	40 07 73 c0 	call  609a40 <___copy_to_user>
  42cb44:	94 10 00 19 	mov  %i1, %o2
  42cb48:	0a c2 00 18 	brnz,pn   %o0, 42cba8 <fault_in_user_windows+0xc8>
  42cb4c:	90 10 00 1d 	mov  %i5, %o0
  42cb50:	82 06 bf ff 	add  %i2, -1, %g1
  42cb54:	b8 07 3f f8 	add  %i4, -8, %i4
  42cb58:	02 c6 80 1c 	brz,pn   %i2, 42cbc8 <fault_in_user_windows+0xe8>
  42cb5c:	b6 06 ff 80 	add  %i3, -128, %i3
  42cb60:	b4 10 00 01 	mov  %g1, %i2
  42cb64:	c2 59 a0 08 	ldx  [ %g6 + 8 ], %g1
  42cb68:	82 08 60 80 	and  %g1, 0x80, %g1
  42cb6c:	0a f8 7f ed 	brnz  %g1, 42cb20 <fault_in_user_windows+0x40>
  42cb70:	fa 5f 23 c0 	ldx  [ %i4 + 0x3c0 ], %i5
  42cb74:	ba 07 67 ff 	add  %i5, 0x7ff, %i5
  42cb78:	82 0f 60 07 	and  %i5, 7, %g1
  42cb7c:	02 f8 7f ef 	brz  %g1, 42cb38 <fault_in_user_windows+0x58>
  42cb80:	b2 10 20 80 	mov  0x80, %i1
  42cb84:	7f ff fc cf 	call  42bec0 <stack_unaligned>
  42cb88:	90 10 00 1d 	mov  %i5, %o0
  42cb8c:	90 10 00 1d 	mov  %i5, %o0
  42cb90:	92 10 00 1b 	mov  %i3, %o1
  42cb94:	40 07 73 ab 	call  609a40 <___copy_to_user>
  42cb98:	94 10 00 19 	mov  %i1, %o2
  42cb9c:	02 fa 3f ee 	brz  %o0, 42cb54 <fault_in_user_windows+0x74>
  42cba0:	82 06 bf ff 	add  %i2, -1, %g1
  42cba4:	90 10 00 1d 	mov  %i5, %o0
  42cba8:	92 10 00 1b 	mov  %i3, %o1
  42cbac:	40 07 81 e5 	call  60d340 <copy_to_user_fixup>
  42cbb0:	94 10 00 19 	mov  %i1, %o2
  42cbb4:	02 f2 3f e7 	brz,pn   %o0, 42cb50 <fault_in_user_windows+0x70>
  42cbb8:	90 10 20 04 	mov  4, %o0
  42cbbc:	b4 06 a0 01 	inc  %i2
  42cbc0:	40 00 be 98 	call  45c620 <do_exit>
  42cbc4:	f4 29 a0 0d 	stb  %i2, [ %g6 + 0xd ]
  42cbc8:	c0 29 a0 0d 	clrb  [ %g6 + 0xd ]
  42cbcc:	81 cf e0 08 	rett  %i7 + 8
  42cbd0:	01 00 00 00 	nop 
  42cbd4:	30 68 00 03 	b,a   %xcc, 42cbe0 <sparc_do_fork>
  42cbd8:	01 00 00 00 	nop 
  42cbdc:	01 00 00 00 	nop 


-- 
Meelis Roos (mroos@linux.ee)
