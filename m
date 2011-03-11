From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 Mar 2011 22:40:32 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <20110311224032.GA1138@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Marcel.

On Fri, Mar 11, 2011 at 10:26:36PM +0100, Marcel van Nies wrote:
> Hi,
> 
> > Regarding the segfault - the easiest way forward would be to split the
> > patch up in smaller chunks so we know which part causes the segfault to happen.
> >
> > I assume you had to hand-apply the revert. If you could post the exact patch
> > you used for revert I will try to split it up in smaller logical parts.
> 
> I attached the patch which I used to revert commit
> 4d14a459857bd151ecbd14bcd37b4628da00792b
> 
> I did a split of this patch, and build kernels with only the memcpy or
> only the memset part reverted.

Thanks for all your effort!
I will during the weekend try to think how we can nail this,
but I'm a bit lost here as we are looking into areas I know little about.

	Sam
