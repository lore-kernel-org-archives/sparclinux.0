From: Matt R Hall <mhcomputing@gmail.com>
Date: Tue, 21 Sep 2004 09:41:29 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <703d4eaa04092102416077e882@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I specifically tested _every single_ kernel version since 2.6.0. It
took me an excruciating period of several weeks to cycle through this
number of dot releases. The stable, working uniprocessor kernel is
2.6.9-rc2. 2.6.9-rc2 specifically failed in SMP mode, but, it worked
in 2.4.xx.

I would not mind that only 2.4.xx works, but I am making a public
acccess UNIX server so I want a clear upgrade path, and the newer
better packet matching support so I can do some sophisticated egress
filtering to prevent abuse. Also, I seek a dependable upgrade path
into the future, which is something 2.4.xx cannot offer for the long
term.

On Mon, 20 Sep 2004 23:34:10 -0700, David S. Miller <davem@davemloft.net> wrote:
> On Mon, 20 Sep 2004 18:40:39 -0700
> Matt R Hall <mhcomputing@gmail.com> wrote:
> 
> > I filed a report about this in kernel.org's bugzilla and it has not
> > received any comments.
> 
> Because the sparc64 kernel maintainer, me, doesn't look at
> kernel.org's bugzilla ever. :-)
> 
> Can you make sure 2.6.9-rc2 has the same problem?
> 
> I don't have any of my SBUS SMP systems active in my array
> of machines lately which is why stability on them has fallen
> on the way side, they're just too damn slow to work with :(
>
