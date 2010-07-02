From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 02 Jul 2010 13:27:44 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <alpine.LSU.2.01.1007021524280.15958@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tuesday 2009-12-22 16:21, Jan Engelhardt wrote:
>On Tuesday 2009-12-22 01:19, Dennis Gilmore wrote:
>>On Monday 21 December 2009 06:06:26 pm Jan Engelhardt wrote:
>>> 
>>> RPM offers the targets sparcv9v/sparc64v (which is, simply put,
>>> cflags += -mtune=niagara).
>>> 
>>> But how would the package manager (apt-get/yum/zypper) decide whether
>>> they are on sun4v or not[...]
>>
>>yum does this by checking /proc/cpuinfo look at /usr/lib/python2.6/site-
>>packages/rpmUtils/arch.py on a F-12 box  and search for sun4v  rpm has a 
>>similar check based on the same information. both will refuse to install a 
>>sparcv9v package on hardware that is not capable of running it.
[...]

But is there a C-programmatical way that does not rely on external
files? /proc may not be mounted. auxv is usually not accessible,
and forking is a sin too. OpenSSL uses assembler tricks and traps
to determine if something has 4v or not, which leaves the realm of C.
But it looks like it's okay, given x86 programs also do asm/cpuid
to determine SSE availability.


Jan
