From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 25 Jan 2011 07:52:47 +0000
Subject: Re: [RFC PATCH 0/7] sparc32: cleanup irq + smp files
Message-Id: <20110125075247.GA29718@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110123213940.GA15063@merkur.ravnborg.org>
In-Reply-To: <20110123213940.GA15063@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 24, 2011 at 04:11:32PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 23 Jan 2011 22:54:38 +0100
> 
> > The patches survied my SPARCclassic config and defconfig.
> > But allnoconfig bails out with an error.
> > 
> > This is because asm-generic/tlb.h require linux/pagemap.h.
> > The include happended implicitly before.
> > 
> > 
> > Workaround is simple - see below.
> > I will try to get it fixed in asm-generic for benefit of all users.
> 
> Please get this fix in asm-generic and merged upstream, then
> repost your series and mention this dependency so I can merge
> in Linus's tree first.

Andrew already fixed it:
http://marc.info/?l=linux-mips&m9593731808647&w=2

I have build tested sparc32 allnoconfig + defconfig.

I will repost my serie when this fix is in mainline.
The updated serie will be on top of sparc-next.

	Sam
