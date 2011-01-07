From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 07 Jan 2011 06:04:24 +0000
Subject: Re: [PATCH 0/4] sparc: drop SBUS ifdefs
Message-Id: <20110107060424.GB18169@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105210217.GA22415@merkur.ravnborg.org>
In-Reply-To: <20110105210217.GA22415@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 06, 2011 at 02:31:13PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 5 Jan 2011 22:02:17 +0100
> 
> > Kristoffer Glembo noticed that SBUS is always defined for SPARC.
> > So I went out and dropped all #ifdef SBUS that were
> > present in SPARC only code.
> > 
> > This touches:
> > - arch/sparc
> > - drivers/net
> > - sound/sparc
> > 
> > But despite this I expect we can add all this to sparc.git.
> > If you prefer I can submit the patches via the usual channels.
> > 
> > Build tested on sparc64 & sparc.
> > 
> > Patches are on top of sparc-next as of yesterday.
> 
> I've decided I'm going to defer on this set of patches for now.
> 
> The real thing to do is to create a include/linux/sbus.h that
> provides the SBUS specific interfaces, and dummy ones when
> CONFIG_SBUS is not defined.
> 
> That way all of the sparc drivers can be enabled unconditionally
> as long as CONFIG_OF is true.

OK.
I will try to look into providing this an resend.

	Sam
