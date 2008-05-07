From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 07 May 2008 22:54:06 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.LNX.4.44L0.0805071835390.15419-100000@netrider.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 7 May 2008, Meelis Roos wrote:

> > Meelis, can you provide an assembly listing of that routine?  It's in
> > drivers/usb/core/hcd.c.  Alternatively, you could try adding printk
> > messages before and after each of those statements, and see how far
> > they get.
> 
> objdump --disassemble hcd.o
...

> 0000000000000e80 <usb_hcd_poll_rh_status>:
>      e80:	9d e3 bf 30 	save  %sp, -208, %sp
>      e84:	c2 5e 20 e8 	ldx  [ %i0 + 0xe8 ], %g1
>      e88:	0e c0 40 47 	brgez,pn   %g1, fa4 <usb_hcd_poll_rh_status+0x124>
>      e8c:	83 30 70 3e 	srlx  %g1, 0x3e, %g1
>      e90:	82 08 60 01 	and  %g1, 1, %g1
>      e94:	2a c0 40 06 	brnz,a,pn   %g1, eac <usb_hcd_poll_rh_status+0x2c>
>      e98:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
>      e9c:	c2 5e 20 d0 	ldx  [ %i0 + 0xd0 ], %g1
>      ea0:	02 c0 40 41 	brz,pn   %g1, fa4 <usb_hcd_poll_rh_status+0x124>
>      ea4:	01 00 00 00 	nop 
>      ea8:	c4 5e 20 d8 	ldx  [ %i0 + 0xd8 ], %g2
>      eac:	a4 07 a7 e7 	add  %fp, 0x7e7, %l2
>      eb0:	90 10 00 18 	mov  %i0, %o0
>      eb4:	c2 58 a0 78 	ldx  [ %g2 + 0x78 ], %g1
>      eb8:	9f c0 40 00 	call  %g1
>      ebc:	92 10 00 12 	mov  %l2, %o1
>      ec0:	a2 92 20 00 	orcc  %o0, 0, %l1
>      ec4:	04 40 00 1f 	ble,pn   %icc, f40 <usb_hcd_poll_rh_status+0xc0>

I'm going to need a little help with this, since I'm not acquainted 
with SPARC assembler.

The task dump showed that the address on the stack was
usb_hcd_poll_rh_status+0x40/0x180, which would be ec0 above.  That
looks like it is the second instruction past the call to
hcd->driver->hub_status_data().  Is that right?  And does one expect 
the return address to be two past the call (call slot or some such 
thing)?

Assuming it is, it means that the hang-up occurs somewhere inside 
uhci_hub_status_data() (in drivers/usb/host/uhci-hub.c).  Meelis, can 
you add a couple of printk statements to that function, one just before 
and one just after the spin_lock_irqsave() line?

Alan Stern

