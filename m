From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Date: Tue, 29 May 2007 12:53:39 +0000
Subject: Re: [2/3] 2.6.22-rc3: known regressions with patches
Message-Id: <465C2253.4070307@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <465C203A.1020200@googlemail.com>
In-Reply-To: <465C203A.1020200@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Ben Collins <bcollins@ubuntu.com>, yoshfuji@linux-ipv6.org, Maximilian Engelhardt <maxi@daemonizer.de>, linux-wireless@vger.kernel.org, developers@islsm.org, =?ISO-8859-2?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Francis Russell <francisrussell@btopenworld.com>, Alan Cox <alan@redhat.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Hi all,

Here is a list of some known regressions in 2.6.22-rc3
with patches available.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Networking

Subject    : Oops with prism54 in 2.6.22-rc3
References : http://lkml.org/lkml/2007/5/26/54
Submitter  : Maximilian Engelhardt <maxi@daemonizer.de>
Handled-By : Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>=20
Patch      : http://lkml.org/lkml/2007/5/27/182
Status     : patch available


Subject    : OOPS triggered by ip(8) deconfiguring a network interface
References : http://bugzilla.kernel.org/show_bug.cgi?id=8491
Submitter  : Ben Collins <bcollins@ubuntu.com>
Patch      : http://marc.info/?l=3Dlinux-netdev&m=117915849224816&w=3D2
             commit 5632c5152aa621885d87ea0b8fdd5a6bb9f69c6f
Status     : bug probably fixed

SATA/PATA

Subject    : pata_via appears to incorrectly detects 40-pin cable
References : http://lkml.org/lkml/2007/5/17/273
Submitter  : Francis Russell <francisrussell@btopenworld.com>
Status     : Not really a regression. Alan seems to have a general fix.
             (Tejun Heo)

Subject    : libata reset-seq merge broke sata_sil on sh
References : http://lkml.org/lkml/2007/5/10/63
Submitter  : Paul Mundt <lethal@linux-sh.org>
Handled-By : Tejun Heo <htejun@gmail.com>
Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
Patch      : http://lkml.org/lkml/2007/5/19/161
Status     : patch available



Sparc64

Subject    : arch/sparc64/time.c doesn't compile on Ultra 1 (no PCI)
References : http://bugzilla.kernel.org/show_bug.cgi?id=8540
Submitter  : Horst H. von Brand <vonbrand@inf.utfsm.cl>
Status     : patch available



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"



