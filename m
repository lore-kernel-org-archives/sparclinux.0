From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 03 Apr 2010 15:13:46 +0000
Subject: Re: Kernel panic - not syncing: Irrecoverable deferred error trap
Message-Id: <1270307626.1761.21.camel@deblnxsrv254.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
In-Reply-To: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2010-04-03 at 01:16 -0700, David Miller wrote:
> I see the problem.
> 
> The XVR-1200 has extra PCI subfunction devices representing secondary
> and further monitors attached to the card.
> 
> These nodes are special and we should not try to drive them.
> 
> Out of curiosity do you have multiple monitors hooked up to the
> XVR-1200 device, or just one?

Ahhh ahhm ... choose a other option, non monitors is hooked up.

> I bet this might explain the XVR-600 failures I could not reproduce,
> as seen by Paul Cao, CC:'d.  Paul if you had two monitors hooked up to
> your XVR-600, try next time installing with just one monitor attached.
> 
> Frans, if you could test the patch below I'd really appreciate it.

Gonna do this compile run next. Just a 2.6.26 or 2.6.34?

> Also, once you get this working, please send me "prtconf -pv" output
> for this machine with both of these graphics cards in it.

As promised, will do.

> Thanks again for your reports and all of your help so far!

And thanks supporting us!

