From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 08 Jan 2009 07:56:25 +0000
Subject: Re: hardirq.h removal broke sparc64 build...
Message-Id: <20090108075625.GA14179@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090107.144310.79937111.davem@davemloft.net>
In-Reply-To: <20090107.144310.79937111.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: rmk+kernel@arm.linux.org.uk, adobriyan@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

> 
> Actually, looking at the patch, where is the part from Alexey
> that does the "fix sparc64"?  I see nothing in the patch that
> would even appear to possibly be for that.  The diffstat is:
> 
>  arch/avr32/kernel/traps.c     |    1 +
>  arch/sh/kernel/traps_32.c     |    1 +
>  drivers/acpi/processor_idle.c |    1 +
>  include/asm-generic/local.h   |    1 -
>  4 files changed, 3 insertions(+), 1 deletion(-)
> 
> Was Alexey's fix removed or lost? :-/

When I made my patch I saw some issues in non-sparc files
but I did not address these as I thought they were generic
bugs addressed by someone else.
I should have checked if the same build error was
also present on x86/arm then :-(

I'm glad to see it is sorted out properly now.

	Sam

