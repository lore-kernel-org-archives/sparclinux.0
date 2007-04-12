From: "Arkadi Shishlov" <arkadi@mebius.lv>
Date: Thu, 12 Apr 2007 00:35:46 +0000
Subject: parport_sunbpp patch, works on ultra2
Message-Id: <op.tqnalwnm3zd5kp@k37>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With 2.6(.20) parport_sunbpp parallel port driver the printing on Ultra2 is
impossible. Most of the characters sent to /dev/lp0 are lost.
The following patch works for me with LPRNG and CUPS, lpr and Windows client
via Samba. I can print test pages from CUPS and Windows, documents with tables.
The printer is very misbehaving HP DeskJet.
Perhaps the code is in wrong place and generic parport infrastructure should be
revisited instead for correct operation of polling. It will fill syslog with
"timeout waiting" at first opportunity. And such amount of udelay()-s is awfull.
Credits for algorith goes to OpenBSD bpp driver author.
Plese CC me, I'm not on list.

--- parport_sunbpp.c~   2007-04-11 19:26:14.000000000 +0300
+++ parport_sunbpp.c    2007-04-12 03:16:14.000000000 +0300
@@ -72,12 +72,50 @@
         sbus_writel(tmp, &regs->p_csr);
  }

+#define __SUNBPP_WAIT 100
+
  static void parport_sunbpp_write_data(struct parport *p, unsigned char d)
  {
         struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+       int i;
+       u8 c;
+
+       /* wait for ack and busy to clear */
+       for (i = 0; i < __SUNBPP_WAIT; ++i) {
+               c = sbus_readb(&regs->p_tcr);
+               if (!(c&(P_TCR_ACK|P_TCR_BUSY)))
+                       break;
+               udelay(1);
+       }
+       if (i = __SUNBPP_WAIT) {
+               printk(KERN_DEBUG "parport_sunbpp_write_data 0x%x: timeout waiting for clear\n", d);
+               return;
+       }

+       /* write data */
         sbus_writeb(d, &regs->p_dr);
-       dprintk((KERN_DEBUG "wrote 0x%x\n", d));
+
+       /* clear strobe */
+       c = sbus_readb(&regs->p_tcr);
+       c &= ~P_TCR_DS;
+       sbus_writeb(c, &regs->p_tcr);
+
+       /* wait for busy */
+       for (i = 0; i < __SUNBPP_WAIT*10; ++i) {
+               c = sbus_readb(&regs->p_tcr);
+               if (c&P_TCR_BUSY)
+                       break;
+               udelay(1);
+       }
+       if (i = __SUNBPP_WAIT*10) {
+               printk(KERN_DEBUG "parport_sunbpp_write_data 0x%x: timeout waiting for busy\n", d);
+               return;
+       }
+
+       /* set strobe */
+       c = sbus_readb(&regs->p_tcr);
+       c |= P_TCR_DS;
+       sbus_writeb(c, &regs->p_tcr);
  }

  static unsigned char parport_sunbpp_read_data(struct parport *p)


BTW, enabling __SUNBPP_DEBUG oopses at frob_control() debug print after echo >/dev/lp0

Apr 11 19:40:34 [kernel] [29853.833191] register_port
Apr 11 19:40:34 [kernel] [29853.833272] parport0: sunbpp at 0x1ffec800000
Apr 11 19:40:54 [kernel] [29873.272196] lp0: using parport0 (interrupt-driven).
Apr 11 19:41:36 [kernel] [29915.174694] Unable to handle kernel paging request at virtual address 00000000ec800000
Apr 11 19:41:36 [kernel] [29915.174722] tsk->{mm,active_mm}->context = 0000000000001e76
Apr 11 19:41:36 [kernel] [29915.174741] tsk->{mm,active_mm}->pgd = fffff80009d66000
Apr 11 19:41:36 [kernel] [29915.174759]               \|/ ____ \|/
Apr 11 19:41:36 [kernel] [29915.174768]               "@'/ .. \`@"
Apr 11 19:41:36 [kernel] [29915.174776]               /_| \__/ |_\
Apr 11 19:41:36 [kernel] [29915.174784]                  \__U_/
Apr 11 19:41:36 [kernel] [29915.174801] bash(5398): Oops [#1]
Apr 11 19:41:36 [kernel] [29915.174824] TSTATE: 0000004411f09601 TPC: 00000000100c6200 TNPC: 00000000100c6204 Y: 00000000    Not tainted
Apr 11 19:41:36 [kernel] [29915.174875] TPC: <parport_sunbpp_frob_control+0x28/0x100 [parport_sunbpp]>
Apr 11 19:41:36 [kernel] [29915.174902] g0: fffff80007e62fe1 g1: 0000000000000003 g2: fffff8001717ec20 g3: 0000000000000000
Apr 11 19:41:36 [kernel] [29915.174933] g4: fffff8001f326560 g5: fffff7ffffc74f80 g6: fffff80007e60000 g7: 0000000000000000
Apr 11 19:41:36 [kernel] [29915.174959] o0: fffff80005b129a0 o1: 00000000000000d0 o2: 0000000000000001 o3: 0000000000000001
Apr 11 19:41:36 [kernel] [29915.174987] o4: 00000000007332e0 o5: 0000000000000001 sp: fffff80007e63001 ret_pc: 0000000000487f38
Apr 11 19:41:36 [kernel] [29915.175035] RPC: <mod_zone_page_state+0x20/0x40>
Apr 11 19:41:36 [kernel] [29915.175060] l0: fffff8001fed1990 l1: 0000000000000001 l2: 000001ffec800000 l3: 000001ffec800016
Apr 11 19:41:36 [kernel] [29915.175085] l4: 000001ffec800015 l5: 0000000000000001 l6: 00000000006d8c28 l7: 000000000042b1a0
Apr 11 19:41:36 [kernel] [29915.175113] i0: fffff8000fe47680 i1: 000000000000000f i2: 000000000000000c i3: fffff80005b129d0
Apr 11 19:41:36 [kernel] [29915.175143] i4: fffff8001ff06960 i5: 0000000000200200 i6: fffff80007e630c1 i7: 00000000100bc2a8
Apr 11 19:41:36 [kernel] [29915.175208] I7: <parport_claim+0x130/0x1e0 [parport]>
Apr 11 19:41:36 [kernel] [29915.175225] Caller[00000000100bc2a8]: parport_claim+0x130/0x1e0 [parport]
Apr 11 19:41:36 [kernel] [29915.175262] Caller[00000000100bc50c]: parport_claim_or_block+0x14/0x80 [parport]
Apr 11 19:41:36 [kernel] [29915.175300] Caller[00000000100cc78c]: lp_open+0xb4/0x200 [lp]
Apr 11 19:41:36 [kernel] [29915.175339] Caller[00000000004a5a80]: chrdev_open+0xc8/0x1a0
Apr 11 19:41:36 [kernel] [29915.175373] Caller[00000000004a0c9c]: __dentry_open+0xa4/0x200
Apr 11 19:41:36 [kernel] [29915.175399] Caller[00000000004a0f0c]: do_filp_open+0x54/0x60
Apr 11 19:41:36 [kernel] [29915.175424] Caller[00000000004a0f60]: do_sys_open+0x48/0x100
Apr 11 19:41:36 [kernel] [29915.175448] Caller[0000000000406c54]: linux_sparc_syscall32+0x3c/0x40
Apr 11 19:41:36 [kernel] [29915.175487] Caller[0000000000065660]: 0x65668
Apr 11 19:41:36 [kernel] [29915.175511] Instruction DUMP: a604a016  aa100011  c28cc2a0 <d20ca015> 11040319  a0100001  d40ca016  90122280  b20e60ff
