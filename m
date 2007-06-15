From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 15 Jun 2007 17:22:13 +0000
Subject: Re: [PATCH] Fix build errors with strict MM checking
Message-Id: <20070615172213.GG11781@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070612231600.GA8953@palantir8>
In-Reply-To: <20070612231600.GA8953@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jun 15, 2007 at 02:11:49AM -0700, William Lee Irwin III wrote:
>> Unhandled paging request vs. DMA errors? This sounds ominous. What
>> CPU type?

On Fri, Jun 15, 2007 at 05:49:07PM +0100, Martin Habets wrote:
> This is a supersparc UP machine. It only happens if I use an SMP kernel,
> and only on one machine out of 6 SS10/SS20 UP/SMP boxes.
> The special thing about this machine is that is has 320MB memory, versus
> 128MB or less on the others. And it has 2 disks, but one other box has
> 2 disks as well.
> I got 2 ross CPUs yesterday. With those no problem so far. Guess I'll
> ignore it for now, maybe stress testing will make it pop up again on
> one of the supersparcs.
> Still, I would like to learn a debugging aproach if/when that time
> comes, the oops is below (sorry Dave).
> In general I'm very content with the SMP performance on 2.6.21.

Usually it's the HyperSPARC's with trouble. I've bricked the sun4m SS20
I've got plugged into the AP9225's and Cisco 2511 somehow (probably the
big power surge that fried everything else, too), so I'll have to dig
for a fresh chassis. Disks OTOH I'm not quite as likely to have around.

It's oopsing on the DVMA virtual region, so debugging techniques are
likely to consist of logging DVMA-relevant MMU manipulations and
fishing for things like protections being wrong, the call stack for
offending calls, (esp. the ones right before you oops) and so on, and
hoping that timings aren't relevant (if they are, there are different,
more complicated things to try). There are a lot of XXX's/FIXME's in
and around IOMMU handling so it may end up related to some of that as
well, though I kind of doubt it.


-- wli
