From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Dec 2009 19:59:21 +0000
Subject: Re: [PATCH 1/2] sparc: us3_cpufreq.c: fix warnings/errors
Message-Id: <20091221195921.GA21868@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
In-Reply-To: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 21, 2009 at 10:28:39PM +0300, Alexander Beregalov wrote:
> 2009/12/21 Alexander Beregalov <a.beregalov@gmail.com>:
> > 2009/12/21 Sam Ravnborg <sam@ravnborg.org>:
> >> On Sun, Dec 20, 2009 at 03:16:35PM +0300, Alexander Beregalov wrote:
> >>> Fix warnings which become build errors since -Werror is used.
> >>> arch/sparc/kernel/us3_cpufreq.c:60: error: 'ret' may be used uninitialized in this function
> >>> arch/sparc/kernel/us3_cpufreq.c:101: error: 'new_bits' may be used uninitialized in this function
> >>
> >> What config produces these warnings?
> >> Do you have CONFIG_BUG_VERBOSE set?
> >>
> >> Also what gcc versio?
> >>
> Ah, this is it.
> 
> # CONFIG_BUG is not set
> 
> Is it sane config ?

Only embedded size constrained configs would
consider this.

The reason for the warning is this snippet from
include/asm-generic/bug.h:

#define BUG() do {} while(0)

The above only comes into effect when CONFIG_BUG is not set.

I dunno what the best fix is here.
Embedded or not - I cannot see why we should continue
execution after a BUG().
Code will assume we panicked and following code not to be executed.

As the comment says:
"Don't use BUG() or BUG_ON() unless there's really no way out;"

I would have expected to see something like this:
#define BUG() do {} while(1)

A never ending loop so the watchdog on embedded systems could
force a reboot. IMO more safe than continue and do random
curruption of stuff all over.

David Howells added the do {} while(0) - so cc: on this mail.

	Sam
