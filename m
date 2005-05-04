From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Wed, 04 May 2005 04:18:25 +0000
Subject: Re: [PATCH] 2.6.x SMP UltraSPARC instability
Message-Id: <1115180305.32454.70.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-b7QQvjce/ByQtNvr1O9w"
List-Id: <sparclinux.vger.kernel.org>
References: <20050503170509.5fa93b26.davem@davemloft.net>
In-Reply-To: <20050503170509.5fa93b26.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--=-b7QQvjce/ByQtNvr1O9w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-03 at 17:05 -0700, David S. Miller wrote:
> Can folks seeing problems on SMP sparc64 boxes with 2.6.x
> give this patch a try?

Both cases compiled with gcc-3_3-branch dated 20040623 (post 3.3.4)

2.6.11 without patch:
crashes after about 2 minutes of uptime

2.6.12-rc3 with patch:
so far it's been up for about 10 minutes with no problems so far... I'm
going to leave it doing some high load tasks while I head out to go see
a movie... hopefully it'll still be up when I get back.

--Jeremy

system is an ultra2, and the following info is as reported under
2.4.29smp

/proc/cpuinfo
cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
promlib         : Version 3 Revision 25
prom            : 3.25.0
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 591.46
Cpu0ClkTck      : 0000000011a4959b
Cpu1Bogo        : 591.46
Cpu1ClkTck      : 0000000011a4959b
MMU Type        : Spitfire
State:
CPU0:           online
CPU1:           online

I've heard scsi is sometimes a factor with some of the 2.6 issues, so
including this for good measure:

/proc/scsi/esp/0=20
Sparc ESP Host Adapter:
        PROM node               f006635c
        PROM name               SUNW,fas
        ESP Model               Happy Meal FAS
        DMA Revision            Rev HME/FAS
        Live Targets            [ 0 1 6 ]

Target #        config3         Sync Capabilities       Disconnect
Wide
0               000000c3        [0f,04]                 yes
yes
1               000000c3        [0f,04]                 yes
yes
6               00000081        [0f,04]                 yes
no

/proc/scsi/scsi=20
Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: MAB3045S SUN4.2G Rev: 1705
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: FUJITSU  Model: MAB3045S SUN4.2G Rev: 1705
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: TOSHIBA  Model: XM5701TASUN12XCD Rev: 0997
  Type:   CD-ROM                           ANSI SCSI revision: 02


--=-b7QQvjce/ByQtNvr1O9w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCeE0ROpjtAl+gMRURAvwUAKDD6qjaogFNBIZWcR7EqlYCZJ0wvwCfYeIC
79Auvew0MCDnEn5MSQZiqm8=
=XacE
-----END PGP SIGNATURE-----

--=-b7QQvjce/ByQtNvr1O9w--

