From: Ralph Mitchell <rmitchell@eds.com>
Date: Thu, 26 Aug 2004 08:31:58 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <412D9FFE.9060206@eds.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary_(ID_ybUb1LXPi7v8D20ccjFTEg)"
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_ybUb1LXPi7v8D20ccjFTEg)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Umm, that doesn't seem to fix it for me.  I don't know if it's much use, 
but the edited boot log is attached.

If there's anything else I can do to help pin this down...

This is on an E450 w/ kernel-2.6.7.

Ralph Mitchell


David S. Miller wrote:

>Does this make the garbled (every other char missing) console
>problem go away?
>
>It isn't the best fix, and if this hack fix works I'll work on
>the real cure.
>
>Thanks.
>
>===== drivers/serial/sunsab.c 1.33 vs edited =====
>--- 1.33/drivers/serial/sunsab.c	2004-05-30 17:43:04 -07:00
>+++ edited/drivers/serial/sunsab.c	2004-08-25 23:14:30 -07:00
>@@ -940,6 +940,7 @@
> 	writeb(up->interrupt_mask1, &up->regs->w.imr1);
> 
> 	sunsab_convert_to_sab(up, con->cflag, 0, baud);
>+	sunsab_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
> 
> 	spin_unlock_irqrestore(&up->port.lock, flags);
> 	
>-
>To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>

--Boundary_(ID_ybUb1LXPi7v8D20ccjFTEg)
Content-type: text/plain; name=serial_fix.cap
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=serial_fix.cap

 * Bringing br0 down... *   Releasing DHCP lease for br0
  [ ok ]
 *   Stopping br0
  [ ok ]
 * Bringing lo down...  [ ok ]
 * Stopping devfsd...  [ ok ]
 * Deactivating swap...  [ ok ]
 * Unmounting filesystems...  [ ok ]
 * Shutting down the Logical Volume Manager...  [ ok ]
 * Remounting remaining filesystems readonly...  [ ok ]
m:sopn l ddvcs
d d wthdt edol oe
Rsatn ytm
Resetting ... 


Can't open input device.
screen not found.
Can't open input device.
Keyboard not present.  Using ttya for input and output.
Keyboard not present.  Using ttya for input and output.


Sun Enterprise 450 (4 X UltraSPARC-II 400MHz), No Keyboard
OpenBoot 3.16, 4096 MB memory installed, Serial #12871523.
Ethernet address 8:0:20:c4:67:63, Host ID: 80c46763.



Initializing Memory \/|\-/|\
Rebooting with command: boot
Boot device: /pci@6,4000/scsi@3/disk@1,0  File and args: 
SILO Version 1.4.8
boot: linux-2.6.7.new
Allocated 8 Megs of memory at 0x40000000 for kernel
\|/-\|/-......  Loaded kernel version 2.6.7

Remapping the kernel... done.
Booting Linux...
POLB u EEBo rm31. 000/11:2
iu eso .. ro@bn0)(c eso .. 0463(etoLnx334)# M h u 60:01 D 04
RH U4
tentades 80:0c:76
nnd  oapgs 264
 M oe 264pgs IObth8
 omlzn:0pgs IObth1
 ihe oe  ae,LF ac:
ul  oeit
enlcmadln:ro=dvsb
I ahtbeetis 06(re 2 53 ye)
osl:clu um eie8x5
eoy 152kaalbe(40 enlcd,96 aa 6kii)[ff8000000000fe80]
airtn ea op. 9.7BgMP

[snip...]

[snip...]

m:AtdtcigRI ras
d uou .
d . uou OE
koradsatn. o
version 2.85 booting

Gentoo Linux; http://www.gentoo.org/
 Copyright 2001-2004 Gentoo Technologies, Inc.; Distributed under the GPL

 * Mounting proc at /proc...  [ ok ]
 * Mounting sysfs at /sys...  [ ok ]
 * Mounting devpts at /dev/pts...  [ ok ]
 * Starting devfsd...Started device management daemon v1.3.25 for /dev

--Boundary_(ID_ybUb1LXPi7v8D20ccjFTEg)--
