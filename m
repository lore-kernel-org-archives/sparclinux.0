From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 23 Nov 2007 15:52:39 +0000
Subject: Re: NETDEV WATCHDOG (3Com 3c905 adapter)
Message-Id: <4746F747.4010906@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4746C44B.8040008@systella.fr>
In-Reply-To: <4746C44B.8040008@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

BERTRAND Jo=EBl wrote:
>     Hello,
>=20
>     Since I have installed a 2.6.23.1 linux kernel on my U60, I can see=20
> several NETDEV WATCHDOG. This trouble never occurs with 2.6.23-rc4.
> This bug occurs after a random uptime.

	I have made the same constation this evening on a amd64/up with two=20
3C905 and a 2.6.21.3 linux kernel... This evening, I have rebooted my=20
U60 with a 2.6.23.8 kernel and the same 3C905 runs fine. Wait and see=20
(but I suspect a kernel bug...).

	For main linux kernel list:

> End of dmesg :
>=20
> NETDEV WATCHDOG: eth2: transmit timed out
> eth2: transmit timed out, tx_status 00 status 8601.
>   diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
> eth2: Interrupt posted but not delivered -- IRQ blocked by another device?
>   Flags; bus-master 1, dirty 144(0) current 144(0)
>   Transmit list 00000000 vs. fffff800a06b0200.
>   0: @fffff800a06b0200  length 8000004a status 0001004a
>   1: @fffff800a06b0260  length 80000062 status 00010062
>   2: @fffff800a06b02c0  length 80000062 status 00010062
>   3: @fffff800a06b0320  length 80000062 status 00010062
>   4: @fffff800a06b0380  length 80000062 status 00010062
>   5: @fffff800a06b03e0  length 80000062 status 00010062
>   6: @fffff800a06b0440  length 80000062 status 00010062
>   7: @fffff800a06b04a0  length 80000062 status 00010062
>   8: @fffff800a06b0500  length 80000062 status 00010062
>   9: @fffff800a06b0560  length 80000062 status 00010062
>   10: @fffff800a06b05c0  length 80000062 status 00010062
>   11: @fffff800a06b0620  length 80000062 status 00010062
>   12: @fffff800a06b0680  length 80000062 status 00010062
>   13: @fffff800a06b06e0  length 8000004a status 0001004a
>   14: @fffff800a06b0740  length 80000062 status 80010062
>   15: @fffff800a06b07a0  length 80000062 status 80010062
> eth2: Resetting the Tx ring pointer.
> eth2:  setting full-duplex.
>=20
> Root rayleigh:[/proc] > cat interrupts
>            CPU0       CPU2
>   0:  318071624  318071584     <NULL>  timer
>   1:          0          0      sun4u  PSYCHO_PCIERR
>   2:          0          0      sun4u  PSYCHO_UE
>   3:          0          0      sun4u  PSYCHO_CE
>   8:     559916          0      sun4u  su(kbd)
>   9:          0    4170845      sun4u  su(mouse)
>  10:          0          0      sun4u  parport0
>  11:          2          0      sun4u  floppy
>  12:          0          0      sun4u  cs4231(capture)
>  13:     789858          0      sun4u  cs4231(play)
>  14:       1329   17123911      sun4u  eth0
>  15:          0   15905664      sun4u  sym53c8xx
>  16:         30          0      sun4u  sym53c8xx
>  17:     364465     223693      sun4u  eth2
>  18:   11043701          0      sun4u  aic7xxx
>  19:          1      50585      sun4u  ohci_hcd:usb2
>  20:          0          0      sun4u  ohci_hcd:usb3
>  21:          1          1      sun4u  ehci_hcd:usb1
>  22:          0          0      sun4u  PSYCHO_PCIERR
>  24:   17346674        332      sun4u  eth1
> Root rayleigh:[/proc] > lspci
> 0000:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus =

> Module
> 0000:00:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
> 0000:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy=20
> Meal (rev 01)
> 0000:00:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M=20
> [Tornado] (rev 78)
> 0000:00:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875=20
> (rev 14)
> 0000:00:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875=20
> (rev 14)
> 0000:00:04.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
> 0000:00:05.0 USB Controller: NEC Corporation USB (rev 43)
> 0000:00:05.1 USB Controller: NEC Corporation USB (rev 43)
> 0000:00:05.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
> 0001:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus =

> Module
> 0001:80:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
> 0001:80:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy=20
> Meal (rev 01)
> Root rayleigh:[/proc] > cat irq/17/smp_affinity
> f
> Root rayleigh:[/proc/net] > cat dev
> Inter-|   Receive                                                | =20
> Transmit
>  face |bytes    packets errs drop fifo frame compressed multicast|bytes=20
>    packets errs drop fifo colls carrier compressed
>   eth1:9421385785 9787261    0    0    0     0          0         0=20
> 2418854910 7465439    0    0    0     0       0          0
>   eth0:3977175515 8320824    0    0    0     0          0         0=20
> 8252404266 9204851    0    0    0     0       0          0
>   eth2:47410723  344515    0    0   51     0          0         0=20
> 31875309  278022  872    0    0     0       0          0
>     lo:240810303 1749211    0    0    0     0          0         0=20
> 240810303 1749211    0    0    0     0       0          0
>=20
>     Regards,
>=20
>     JKB
