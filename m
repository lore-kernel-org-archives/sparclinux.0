From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Tue, 01 May 2007 08:30:02 +0000
Subject: Re: [PATCH 0/11] Consolidation of Open Firmware routines
Message-Id: <Pine.LNX.4.61.0705011028090.18504@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
In-Reply-To: <20070501172250.80707fb8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, "David S. Miller" <davem@davemloft.net>


On May 1 2007 17:22, Stephen Rothwell wrote:
>
>Just thought I would show you all where I am up to.  I have moved from
>openfw.h, drivers/openf and CONFIG_OPENFW to of.h, drivers/of and
>CONFIG_OF - if this offends anyone please scream soon so I can change
>that back.

/me screams. There was already talk about abbreviations [
http://lkml.org/lkml/2006/12/5/7 and replies ], and thank god
"drivers/fw" did not made it (fw: firmware, firewall, firewire...)

>The current diffstat looks like below, so some progress has been made:
>
> arch/powerpc/Kconfig              |    3 +
> arch/powerpc/kernel/of_device.c   |  122 +----------------
> arch/powerpc/kernel/prom.c        |  249 +---------------------------------
> arch/sparc/Kconfig                |    3 +
> arch/sparc/kernel/of_device.c     |  151 +++-----------------
> arch/sparc/kernel/prom.c          |  173 +-----------------------
> arch/sparc/kernel/time.c          |    2 +-
> arch/sparc64/Kconfig              |    3 +
> arch/sparc64/kernel/auxio.c       |    2 +-
> arch/sparc64/kernel/of_device.c   |  164 ++++------------------
> arch/sparc64/kernel/power.c       |    2 +-
> arch/sparc64/kernel/prom.c        |  173 +-----------------------
> arch/sparc64/kernel/time.c        |    2 +-

should be ok,

> drivers/Kconfig                   |    2 +
> drivers/Makefile                  |    1 +
> drivers/of/Kconfig                |    3 +
> drivers/of/Makefile               |    2 +
> drivers/of/base.c                 |  274 +++++++++++++++++++++++++++++++++++++
> drivers/of/device.c               |  131 ++++++++++++++++++

but i'd kinda want drivers/openfirmware, even if it's a bit longer.

> include/asm-powerpc/of_device.h   |   22 +---
> include/asm-powerpc/of_platform.h |   38 +-----
> include/asm-powerpc/prom.h        |   47 ++-----
> include/asm-sparc/of_device.h     |   49 +------
> include/asm-sparc/of_platform.h   |   32 +++++
> include/asm-sparc/prom.h          |   65 +++------
> include/asm-sparc64/of_device.h   |   50 +------
> include/asm-sparc64/of_platform.h |   33 +++++
> include/asm-sparc64/prom.h        |   65 +++------
> include/linux/of.h                |   60 ++++++++
> include/linux/of_device.h         |   26 ++++
> include/linux/of_platform.h       |   55 ++++++++
>
>The battle continues :-)
>--
>Cheers,
>Stephen Rothwell                    sfr@canb.auug.org.au
>http://www.canb.auug.org.au/~sfr/
>

Jan
-- 
