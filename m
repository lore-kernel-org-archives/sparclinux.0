From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 25 Jan 2008 17:11:15 +0000
Subject: Re: 2.6.24-rc8-mm1: old sparc64 bug
Message-Id: <s5hhch1j0ek.wl%tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<200801250104.34669.m.kozlowski@tuxland.pl>
In-Reply-To: <200801250104.34669.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, perex@perex.cz

At Fri, 25 Jan 2008 01:04:34 +0100,
Mariusz Kozlowski wrote:
> 
> Hello,
> 
> 	I was digging through the gentoo bugzilla and found this:
> 
> http://bugs.gentoo.org/show_bug.cgi?id1823
> 
> As you see this bug is present since at least 2.6.17. I can reproduce
> that here on my hardware with 2.6.24-rc8-mm1. All you need to do is install
> mp3blaster on sparc64, run:
> 
> $ mp3blaster some_mp3_file.mp3 
> 
> and stop it by pressing ctrl-c. It oopses when you stop it. It doesn't happen
> every time but it'll oops in a few tries.

This looks similar like a bug I fixed ago.  Damn, it's still there.

Could you build with CONFIG_SND_DEBUG=y ?  It addas some sanity checks
and might catch the fatal condition.


thanks,

Takashi
