From: Paul Rolland <rol@as2917.net>
Date: Thu, 10 Jan 2008 18:16:58 +0000
Subject: Re: 3Com NIC
Message-Id: <20080110191658.49c49412@tux.DEF.witbe.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4786592E.6080303@systella.fr>
In-Reply-To: <4786592E.6080303@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: BERTRAND =?ISO-8859-1?Q?Jo=EBl?= <joel.bertrand@systella.fr>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, rol@witbe.net

Hello,

On Thu, 10 Jan 2008 18:43:10 +0100
BERTRAND Jo=EBl <joel.bertrand@systella.fr> wrote:

> 	ifconfig returns :
>=20
> eth2      Link encap:Ethernet  HWaddr 00:04:75:df:1c:6d
>            inet adr:192.168.253.1  Bcast:192.168.253.255=20
> Masque:255.255.255.0
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:1019611 errors:0 dropped:0 overruns:782 frame:0
>            TX packets:1244862 errors:4389 dropped:0 overruns:0 carrier:0
>            collisions:0 lg file transmission:1000
>            RX bytes:111193503 (106.0 MiB)  TX bytes:1119932615 (1.0 GiB)
>            Interruption:17 Adresse de base:0x8000
>=20
> 	and dmesg :
>=20
> NETDEV WATCHDOG: eth2: transmit timed out
> eth2: transmit timed out, tx_status 00 status 8601.
>    diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
> eth2: Interrupt posted but not delivered -- IRQ blocked by another device?
>    Flags; bus-master 1, dirty 224(0) current 224(0)
>    Transmit list 00000000 vs. fffff800a05ce200.
>    0: @fffff800a05ce200  length 8000007d status 0001007d
>    1: @fffff800a05ce260  length 8000004e status 0001004e
>    2: @fffff800a05ce2c0  length 8000004a status 0001004a
>    3: @fffff800a05ce320  length 80000048 status 00010048
>    4: @fffff800a05ce380  length 8000004a status 0001004a
>    5: @fffff800a05ce3e0  length 80000042 status 00010042
>    6: @fffff800a05ce440  length 8000004e status 0001004e
>    7: @fffff800a05ce4a0  length 80000042 status 00010042
>    8: @fffff800a05ce500  length 8000004e status 0001004e
>    9: @fffff800a05ce560  length 80000048 status 00010048
>    10: @fffff800a05ce5c0  length 8000004a status 0001004a
>    11: @fffff800a05ce620  length 8000004e status 0001004e
>    12: @fffff800a05ce680  length 80000042 status 00010042
>    13: @fffff800a05ce6e0  length 80000042 status 00010042
>    14: @fffff800a05ce740  length 80000042 status 80010042
>    15: @fffff800a05ce7a0  length 80000052 status 80010052
> eth2: Resetting the Tx ring pointer.
>=20
> rayleigh:[~] > cat /proc/interrupts
>             CPU0       CPU2
>    0:  561601936  561601824     <NULL>  timer
>    1:          0          0      sun4u  PSYCHO_PCIERR
>    2:          0          0      sun4u  PSYCHO_UE
>    3:          0          0      sun4u  PSYCHO_CE
>    8:     461146          0      sun4u  su(kbd)
>    9:          0    3350888      sun4u  su(mouse)
>   10:          0          0      sun4u  parport0
>   11:          2          0      sun4u  floppy
>   12:          0          0      sun4u  cs4231(capture)
>   13:     360263          0      sun4u  cs4231(play)
>   14:          0   36484826      sun4u  eth0
>   15:          0   27118288      sun4u  sym53c8xx
>   16:         30          0      sun4u  sym53c8xx
>   17:     906177    1171078      sun4u  eth2
>   18:   19345145          0      sun4u  aic7xxx
>   19:          1     584788      sun4u  ohci_hcd:usb2
>   20:          0          0      sun4u  ohci_hcd:usb3
>   21:          1        467      sun4u  ehci_hcd:usb1
>   22:          0          0      sun4u  PSYCHO_PCIERR
>   24:   27308743          0      sun4u  eth1
> rayleigh:[~] >

Is this only with eth2 ? It seems to be the only one to have interrupts
delivered to CPU0 and CPU2...=20

Just my $0.02 ;)

Paul

--=20
Paul Rolland                                E-Mail : rol(at)witbe.net
Witbe.net SA                                Tel. +33 (0)1 47 67 77 77
Les Collines de l'Arche                     Fax. +33 (0)1 47 67 77 99
F-92057 Paris La Defense                    RIPE : PR12-RIPE

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateu=
r=20
"Some people dream of success... while others wake up and work hard at it" =


"I worry about my child and the Internet all the time, even though she's to=
o=20
young to have logged on yet. Here's what I worry about. I worry that 10 or =
15=20
years from now, she will come to me and say 'Daddy, where were you when the=
y=20
took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation=20
