From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 19 Dec 2004 16:22:13 +0000
Subject: [PATCH]: sbus_free_consistent() causes oops on 2.4.28
Message-Id: <20041219162213.GA31287@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Using sbus_free_consistent() on 2.4.28 causes the oops below. An rmmod
of a module triggered that call. Porting back the 2.6 code solves the issue.

Please apply. Best regards,
Martin

        Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
----

--- linux-2.4.28/arch/sparc/kernel/ioport.c.orig	2004-12-19 15:48:46.886590136 +0000
+++ linux-2.4.28/arch/sparc/kernel/ioport.c	2004-12-19 15:50:08.287215360 +0000
@@ -304,7 +304,7 @@
 void sbus_free_consistent(struct sbus_dev *sdev, long n, void *p, u32 ba)
 {
 	struct resource *res;
-	unsigned long pgp;
+	struct page *pgv;
 
 	if ((res = _sparc_find_resource(&_sparc_dvma,
 	    (unsigned long)p)) = NULL) {
@@ -328,10 +328,10 @@
 	kfree(res);
 
 	/* mmu_inval_dma_area(va, n); */ /* it's consistent, isn't it */
-	pgp = (unsigned long) phys_to_virt(mmu_translate_dvma(ba));
+	pgv = mmu_translate_dvma(ba);
 	mmu_unmap_dma_area(ba, n);
 
-	free_pages(pgp, get_order(n));
+	__free_pages(pgv, get_order(n));
 }

---- 
 /*
ksymoops 2.4.9 on sparc 2.4.28.  Options used
     -v /boot/vmlinux-2.4.28 (specified)
     -k ./ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.28/ (default)
     -m /boot/System.map-2.4.28 (specified)

Error (regular_file): Oops_next_file stat oops failed
ksymoops: No such file or directory
Unable to handle kernel paging request at virtual address f3185000
tsk->{mm,active_mm}->context = 0000019f
tsk->{mm,active_mm}->pgd = fc022400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
rmmod.modutils(423): Oops
PSR: 408000c7 PC: f0045008 NPC: f004500c Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 00474c49 g1: fe367a40 g2: 02d854d0 g3: f087f294 g4: 00020c00 g5: 00000094 g6: f2c8c000 g7: ee00107e
o0: f31854f0 o1: 00000000 o2: 00000fff o3: fff0f000 o4: 5003a01a o5: 00000001 sp: f2c8ddb0 o7: fe367a40
l0: f018f954 l1: 00000001 l2: 00000000 l3: 00002c83 l4: f018f91c l5: 400000a0 l6: 00000001 l7: f01d2800
i0: f2c891b4 i1: 00000000 i2: fe369400 i3: f01d2c44 i4: f0169000 i5: f0165000 fp: f2c8de18 i7: fe3683a4
Caller[fe3683a4]
Caller[f00283d4]
Caller[f00284cc]
Caller[f0010184]
Caller[0001a300]
Instruction DUMP: 90100010  81c7e008  91e80010 <c4022018> 8530a00e  8088a001  82022014  1280000b  84102001 


>>PC;  f0045008 <__free_pages+0/48>   <==
>>g1; fe367a40 <[snd-sun-dbri]snd_dbri_free+78/cc>
>>g3; f087f294 <end+687aac/e119878>
>>g6; f2c8c000 <end+2a94818/e119878>
>>o0; f31854f0 <end+2f8dd08/e119878>
>>sp; f2c8ddb0 <end+2a965c8/e119878>
>>o7; fe367a40 <[snd-sun-dbri]snd_dbri_free+78/cc>
>>l0; f018f954 <contig_page_data+38/3ac>
>>l4; f018f91c <contig_page_data+0/3ac>
>>l7; f01d2800 <uidhash_table+9c/400>
>>i0; f2c891b4 <end+2a919cc/e119878>
>>i2; fe369400 <[snd-sun-dbri].text.end+1035/1095>
>>i3; f01d2c44 <zone_table+0/c>
>>i4; f0169000 <large_digits.2+5320/215a8>
>>i5; f0165000 <large_digits.2+1320/215a8>
>>fp; f2c8de18 <end+2a96630/e119878>
>>i7; fe3683a4 <[snd-sun-dbri]dbri_exit+14/3b>

Trace; fe3683a4 <[snd-sun-dbri]dbri_exit+14/3b>
Trace; f00283d4 <free_module+114/14c>
Trace; f00284cc <sys_delete_module+c0/2ac>
Trace; f0010184 <syscall_is_too_hard+34/40>
Trace; 0001a300 Before first symbol

Code;  f0044ffc <get_zeroed_page+24/30>
00000000 <_PC>:
Code;  f0044ffc <get_zeroed_page+24/30>
   0:   90 10 00 10       mov  %l0, %o0
Code;  f0045000 <get_zeroed_page+28/30>
   4:   81 c7 e0 08       ret 
Code;  f0045004 <get_zeroed_page+2c/30>
   8:   91 e8 00 10       restore  %g0, %l0, %o0
Code;  f0045008 <__free_pages+0/48>   <==   c:   c4 02 20 18       ld  [ %o0 + 0x18 ], %g2   <==Code;  f004500c <__free_pages+4/48>
  10:   85 30 a0 0e       srl  %g2, 0xe, %g2
Code;  f0045010 <__free_pages+8/48>
  14:   80 88 a0 01       btst  1, %g2
Code;  f0045014 <__free_pages+c/48>
  18:   82 02 20 14       add  %o0, 0x14, %g1
Code;  f0045018 <__free_pages+10/48>
  1c:   12 80 00 0b       bne  48 <_PC+0x48>
Code;  f004501c <__free_pages+14/48>
  20:   84 10 20 01       mov  1, %g2


1 error issued.  Results may not be reliable.
