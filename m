From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 12 Feb 2008 22:10:09 +0000
Subject: Re: [Bugme-new] [Bug 9943] New: on E450 after shutdown doesn't go
Message-Id: <20080212141009.ba27e1b0.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


(please respond via emailed reply-to-all, not via the bugzilla web
interface)

On Tue, 12 Feb 2008 13:54:55 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9943
>=20
>            Summary: on E450 after shutdown doesn't go to OK or power off
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.24.2
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: SPARC64
>         AssignedTo: platform_sparc64@kernel-bugs.osdl.org
>         ReportedBy: marvin@mydatex.cz
>=20
>=20
> Latest working kernel version: 2.6.20
> Earliest failing kernel version: 2.6.24.2
> Distribution: Debian Etch
> Hardware Environment: Sun E450 2xCPU400MHz/1GB Ram
> Software Environment: kernel
> Problem Description: after shutdown kernel doesn't power off machine or j=
ump to
> OK prompt
>=20
> Steps to reproduce:
> as root type poweroff
>=20

A regression..

I'm seeing the same problem in 2.6.25-rc1 on x86_64, due to something which
changed in the softlockup detector (it's a mystery and debugging is in
progress).  Setting CONFIG_DETECT_SOFTLOCKUP=3Dn "fixes" it.

But 2.6.24 is OK.

