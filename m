From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 07 Jan 2011 20:31:19 +0000
Subject: Re: sparc boot failure due to perf init
Message-Id: <20110107203119.GA30408@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110107201805.GA28104@merkur.ravnborg.org> <1294431832.2016.457.camel@laptop> <1294432055.2016.458.camel@laptop>
In-Reply-To: <1294432055.2016.458.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Miller <davem@davemloft.net>, lkml <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Fri, Jan 07, 2011 at 09:27:35PM +0100, Peter Zijlstra wrote:
> On Fri, 2011-01-07 at 21:23 +0100, Peter Zijlstra wrote:
> > On Fri, 2011-01-07 at 21:18 +0100, Sam Ravnborg wrote:
> > > This was introduced by: 
> > > "perf, arch: Cleanup perf-pmu init vs lockup-detector" - 004417a6d468e24399e383645c068b498eed84ad
> > > 
> > > I did not see any obvious fix.
> > > (To avoid it is simple - I can disable it in my config).
> > 
> > Or you can switch back to arch_initcall() for now, it'll cause the
> > generic watchdog stuff not to work, but that's a lot less important.
> > 
> > I'll have a chat with Dave on how to best sort all this.
> 
> That is, simply revert the sparc bit for now.

For now I just disabled the option as I am trying to
debug a console related problem and do not need the
perf_event support (or at least I do not know I need it :-) ).

Then you guys can sort it out and I can test any patches
you come up with.

	Sam

