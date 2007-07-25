From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 25 Jul 2007 23:14:40 +0000
Subject: Re: [Bugme-new] [Bug 8811] New: us3_cpufreq not working on blade
Message-Id: <20070725161440.0b49cbd4.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, 25 Jul 2007 14:27:00 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8811
>=20
>            Summary: us3_cpufreq not working on blade 2000 with 2xUltraSPA=
RC
>                     IIIcu 900MHz
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.22.1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: SPARC64
>         AssignedTo: platform_sparc64@kernel-bugs.osdl.org
>         ReportedBy: vallesroc@gmail.com
>=20
>=20
> Most recent kernel where this bug did not occur: -
> Distribution: Gentoo/Linux
> Hardware Environment: Sun Blade 2000, 2xUltraSPARC IIIcu 900MHz 8mb cache=
, 4GB
> RAM
> Software Environment: cpufrequtils-002 from
> http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html,
> installed from gentoo ebuild.
>=20
> Problem Description:
> cpufreq-info reports frequency ranges just fine, and after setting the go=
vernor
> to "powersave" will report current cpufreq as the minimum one, yet the cpu
> frequency is definitivelly not lowered, because it'll take the same time =
to do
> an mplayer -noaudio -benchmark movie.avi
>=20
> Steps to reproduce:
> 1. Load the us3_cpufreq kernel module
> 2. Set the governor to powersave
>=20
