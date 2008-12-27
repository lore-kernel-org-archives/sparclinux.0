From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 27 Dec 2008 07:03:05 +0000
Subject: Re: [PATCH] sparc: use .data.init_task section for init_thread_union
Message-Id: <20081227070305.GA27736@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081221204054.GA18284@uranus.ravnborg.org>
In-Reply-To: <20081221204054.GA18284@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Dec 26, 2008 at 03:33:50PM -0800, David Miller wrote:
> From: Kyle McMartin <kyle@infradead.org>
> Date: Sun, 21 Dec 2008 15:45:01 -0500
> 
> > On Sun, Dec 21, 2008 at 09:40:54PM +0100, Sam Ravnborg wrote:
> > > Use a dedicated aligned section for the init_thread_union
> > > variable and declare this section in vmlinux.lds.
> > > 
> > > This align sparc with most other architectures.
> > > Eventually this allow the init_task bits to be unified across all architectures.
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Kyle McMartin <kyle@mcmartin.ca>
> > 
> > I'm working on v2 of my init_task patchset, I'll try to post it to
> > linux-arch this evening or Monday.
> 
> Is this patch from Sam going into Kyle's patch set or should
> I apply it directly to sparc-next-2.6?
> 
> Just let me know...
I suggest that you take it via sparc-next-2.6.

With your usual track schedule you will soon have this
merged and Kyle can rebase on top of linus' tree.

This will also allow us to do some minimal testing to
check that the conversion to the vmlinux.lds based
alignmnet does not cause any troubles before we use
the generic version.

I will follow up if there is any fallout.


	Sam
