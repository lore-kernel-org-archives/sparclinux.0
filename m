From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Fri, 07 Jan 2011 20:23:52 +0000
Subject: Re: sparc boot failure due to perf init
Message-Id: <1294431832.2016.457.camel@laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <20110107201805.GA28104@merkur.ravnborg.org>
In-Reply-To: <20110107201805.GA28104@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Miller <davem@davemloft.net>, lkml <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Fri, 2011-01-07 at 21:18 +0100, Sam Ravnborg wrote:
> This was introduced by: 
> "perf, arch: Cleanup perf-pmu init vs lockup-detector" - 004417a6d468e24399e383645c068b498eed84ad
> 
> I did not see any obvious fix.
> (To avoid it is simple - I can disable it in my config).

Or you can switch back to arch_initcall() for now, it'll cause the
generic watchdog stuff not to work, but that's a lot less important.

I'll have a chat with Dave on how to best sort all this.
