From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Wed, 20 Aug 2014 10:45:31 +0000
Subject: Re: Sym2 scsi hang on boot on sparc64
Message-Id: <20140820104531.GF9911@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1408191420150.4929@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1408191420150.4929@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello,

On Tue, Aug 19, 2014 at 11:48:43PM +0300, Aaro Koskinen wrote:
> > commit 480cadc2b7e0fa2bbab20141efb547dfe0c3707c
> > Author: Guenter Roeck <linux@roeck-us.net>
> > Date:   Sun Aug 10 05:54:25 2014 -0700
> >=20
> >     scsi: Fix qemu boot hang problem
> >=20
> > Could you try with a kernel that has that fix?
>=20
> Yes, the box boots now fine with the fix.

Unfortunately only the scsi is fixed on an UP=20
 Sun (TM) Enterprise 250 (UltraSPARC-II 296MHz), OpenBoot 3.30, 512 MB memo=
ry=20
here, later during startup the machine get a RED STATE exception and
reboots.

Any ideas ?

Thanks,
  Hermann

...
[ ok ] Starting enhanced syslogd: rsyslogd
CPU0 RED State Exception

  CPUVersion:  0017.0011.2000.0507
  UPAConfig:   0000.06b6.34c0.803b
  LSU-Control: 0000.0000.0000.0000
  ECErrEnable: 0000.0000.0000.0007

  AFAR:        0000.01fe.0180.2800
  AFSR:        0000.0000.0000.0000

  DMMU SFAR:   0000.0000.f786.8004
  DMMU SFSR:   0000.0000.0000.0000
  IMMU SFSR:   0000.0000.0000.0011

TL=0000.0000.0000.0005 TT=0000.0000.0000.0064
   TPC=0000.0000.0042.4c80 TnPC=0000.0000.0042.4c84 TSTATE=0000.0000.1104.1=
402
TL=0000.0000.0000.0004 TT=0000.0000.0000.0064
   TPC=0000.0000.0042.4c80 TnPC=0000.0000.0042.4c84 TSTATE=0000.0000.1104.1=
402
TL=0000.0000.0000.0003 TT=0000.0000.0000.0064
   TPC=0000.0000.0042.4c80 TnPC=0000.0000.0042.4c84 TSTATE=0000.0000.1104.1=
402
TL=0000.0000.0000.0002 TT=0000.0000.0000.0064
   TPC=0000.0000.0042.0c80 TnPC=0000.0000.0042.0c84 TSTATE=0000.0000.1104.1=
402
TL=0000.0000.0000.0001 TT=0000.0000.0000.0064
=EF=BF=BD  TPC=0000.0000.0044.cac0 TnPC=0000.0000.0044.cac4 TSTATE=0000.000=
0.1100.1602

--=20
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres=20
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
