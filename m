From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 16 Feb 2005 03:20:18 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or
Message-Id: <20050215192018.36c9c7e8.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl>
	<200502152010.22880.adaplas@hotpop.com>
	<20050215084958.1f68b39b.davem@davemloft.net>
	<200502160328.00148.aragorn@tiscali.nl>
In-Reply-To: <200502160328.00148.aragorn@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <aragorn@tiscali.nl>
Cc: adaplas@pol.net, debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, 16 Feb 2005 03:27:51 +0100
Frans Pop <aragorn@tiscali.nl> wrote:

> Excellent!
> Tested the patch with 2.6.11-rc3-bk2 and AFAICT it completely restores the 
> old behavior. I guess that solves the regression since 2.6.10-rc2.
> 
> Please let me know if this patch will be submitted for inclusion as is so 
> I can also submit it for inclusion in the Debian 2.6.10 kernel.

I applied it and will push upstream.

> I would like to set a lower default resolution as my monitor barely 
> supports 1152x900@66. I tried two things:
> - # eeprom output-device=screen:r1024x768x70
>   This seems to be completely ignored during boot; resolution is still
>   1152x900.

The PROM console driver will only accept certain settings.  I believe
the allowable settings is documented in the Sun Framebuffer Handbook
or something like that.

> - boot with parameter 'video=atyfb:1024x768@70'
>   This does work, but csync is not set to high and so the monitor again
>   goes into suspend; after 'fbset -csync high' the monitor turns on.
>   Is csync something that needs to be set by the user or should the driver
>   take care of that also at frequencies other then 1152x900?

Unfortunately, the user needs to specify this.  I, at one point, even
convinced the XFREE86 mach64 maintainer to enable CSYNC by default
and that broke things for some users and thus the default had to be
changed back to off.

Therefore the kernel fb driver shouldn't turn CSYNC on by default either.

> The second question concerns the use of Stop-A.

If you tell the kernel to use a different resolution than the PROM had,
stop-a is not going to work.
