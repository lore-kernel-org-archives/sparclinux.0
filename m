From: Randy Dunlap <rdunlap@xenotime.net>
Date: Wed, 09 Jul 2008 17:55:04 +0000
Subject: Re: [Bugme-new] [Bug 11059] New: Config category
Message-Id: <20080709105504.9be98ee7.rdunlap@xenotime.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed,  9 Jul 2008 01:23:04 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id059
> 
>            Summary: Config category "Processor type and features" absent
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.25.10
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: SPARC64
>         AssignedTo: platform_sparc64@kernel-bugs.osdl.org
>         ReportedBy: linux0@ivs.selfip.org
> 
> 
> On x86, this problem can be reproduced by giving
> ARCH=sparc64
> as a parameter to 'make'. as in:
> make ARCH=sparc64 xconfig
> 
> Distribution: Debian Etch (4)
> Hardware Environment:
> Ultra 80
> TI UltraSparc II  (BlackBird)
> 
> Software Environment:
> gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)
> libc6 2.3.6.dsl-13
> 
> Problem Description:
> when doing
> make ARCH=sparc64 xconfig
> Configuration category "Processor type and features" is absent and all items
> which would be it's contents appear at the top level.
> 
> Steps to reproduce:
> make ARCH=sparc64 xconfig
> or 
> make ARCH=sparc64 menuconfig
> specifying ARCH is not necessary when actually on a SPARC.



I have posted one possible patch for this at
http://bugzilla.kernel.org/attachment.cgi?id771&action=view


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
