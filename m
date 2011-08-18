From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 18 Aug 2011 09:49:56 +0000
Subject: Re: [PATCH] sparc: fix array bounds error setting up PCIC NMI trap
Message-Id: <20110818094956.GA3616@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1313655297-20075-1-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1313655297-20075-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 18, 2011 at 10:25:15AM +0100, Ian Campbell wrote:
> On Thu, 2011-08-18 at 09:59 +0100, David Miller wrote:
> > From: Ian Campbell <ian.campbell@citrix.com>
> > Date: Thu, 18 Aug 2011 09:14:57 +0100
> > 
> > >>From a sparc64 defconfig:
> > >   CC      arch/sparc/kernel/pcic.o
> > 
> > A sparc64 defconfig?  This is code only built for 32-bit sparc :-)
> 
> My local script confused me, it translated sparc64 into ARCH=sparc for
> me, where it turns out the defconfig = sparc32_defconfig, so I was
> actually building 32 bit. Sorry about that.
> 
> Turns out I also saw this on 32-bit sparc defconfig, which is hardly
> surprising given the two .configs are exactly the same ;-)
sparse complains too - I just never got around to fix it up.

If you do nto beat me I will look at it soon.

	Sam
