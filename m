From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 15 Feb 2007 22:54:37 +0000
Subject: Re: [Bugme-new] [Bug 8018] New: Problem with interrupt handling on
Message-Id: <20070215145437.f6a37584.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, 15 Feb 2007 10:54:50 -0800
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8018
>=20
>            Summary: Problem with interrupt handling on E450
>     Kernel Version: 2.6.20
>             Status: NEW
>           Severity: normal
>              Owner: platform_sparc64@kernel-bugs.osdl.org
>          Submitter: marvin@mydatex.cz
>=20
>=20
> Most recent kernel where this bug did *NOT* occur: 2.6.16.40
> Distribution: Debian SID
> Hardware Environment: Sun E450 2xUltra Sparc 400Mhz 1GB Ram
> Software Environment:
> Problem Description: With 2.6.16.40 E450 works well booted OK. I compile =
2.6.20
> and kernel booted very slow. Ethernet (HappyMeal) are detected but doesn'=
t work.
> Sym875 SCSI controller after detecting devices start ABORT and RESET oper=
ation
> on each scsi ID. In dmesg I see that interrups assigned are differnt than=
 in
> 2.6.16.40. On E250 with the same SCIS controller and one Ultra Sparc 400 =
all
> works normaly.
>=20
> Steps to reproduce:
> Compile kernel and boot.
>=20
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.
>=20
> ------- Additional Comment #1 From Daniel Smolik  2007-02-15 14:31 -------
>=20
> I compile some kernel and last working is 2.6.17.14 and first that didn't=
 work
> 2.6.18
