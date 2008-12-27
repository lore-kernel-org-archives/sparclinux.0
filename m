From: Kyle McMartin <kyle@infradead.org>
Date: Sat, 27 Dec 2008 15:49:25 +0000
Subject: Re: [PATCH] sparc: use .data.init_task section for
Message-Id: <20081227154925.GB29678@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081221204054.GA18284@uranus.ravnborg.org>
In-Reply-To: <20081221204054.GA18284@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Dec 27, 2008 at 08:03:05AM +0100, Sam Ravnborg wrote:
> On Fri, Dec 26, 2008 at 03:33:50PM -0800, David Miller wrote:
> > From: Kyle McMartin <kyle@infradead.org>
> > Date: Sun, 21 Dec 2008 15:45:01 -0500
> > 
> > > On Sun, Dec 21, 2008 at 09:40:54PM +0100, Sam Ravnborg wrote:
> > > > Use a dedicated aligned section for the init_thread_union
> > > > variable and declare this section in vmlinux.lds.
> > > > 
> > > > This align sparc with most other architectures.
> > > > Eventually this allow the init_task bits to be unified across all architectures.
> > > > 
> > > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > > Cc: Kyle McMartin <kyle@mcmartin.ca>
> > > 
> > > I'm working on v2 of my init_task patchset, I'll try to post it to
> > > linux-arch this evening or Monday.
> > 
> > Is this patch from Sam going into Kyle's patch set or should
> > I apply it directly to sparc-next-2.6?
> > 
> > Just let me know...
> I suggest that you take it via sparc-next-2.6.
> 
> With your usual track schedule you will soon have this
> merged and Kyle can rebase on top of linus' tree.

Aye, with the coming sparc merge this is the sensible option. :)

cheers, Kyle
