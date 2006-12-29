From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Fri, 29 Dec 2006 22:47:25 +0000
Subject: Re: [PATCH] sparc64: isa.c should cope with OBP nodes with no
Message-Id: <1167432446.7284.125.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <1166915246238-git-send-email-richm@oldelvet.org.uk>
In-Reply-To: <1166915246238-git-send-email-richm@oldelvet.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2006-12-28 at 21:44 -0800, David Miller wrote:
> From: richm@oldelvet.org.uk
> Date: Sat, 23 Dec 2006 23:07:25 +0000
> 
> > From: Richard Mortimer <richm@oldelvet.org.uk>
> > 
> > The todm5819 Openboot device node on Netra X1 does not have a "reg"
> > property. In this case of_get_property returns NULL resulting in an
> > Oops. Avoid this by returning from isa_dev_get_resource() without
> > attempting to request_resource().
> > 
> > Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>
> 
> Thanks for catching this.
> 
> It's really aweful how we return the "pregs" here but it's
> ultimately unused, because even though we end up passing it
> to isa_dev_get_irq() that function doesn't even use the pregs
> argument.
> 
> So let's just return void from isa_dev_get_resource() and drop
> the pregs arg from isa_dev_get_irq().
> 
> I'll apply the following as ths fix, thanks again.
> 
Hi David,

I didn't get a fix with this mail and cannot see any on your git trees
on kernel.org (then again I may have been looking at the wrong ones).

As far as the fix is concerned I did originally send you two patches.
The first was the fix for the problem and the second cleaned up the
pregs issue. Not that it bothers me. I'm happy if the kernel boots :-)

Richard

-- 
Richard Mortimer <richm@oldelvet.org.uk>

