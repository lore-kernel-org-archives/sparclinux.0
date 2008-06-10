From: David Miller <davem@davemloft.net>
Date: Tue, 10 Jun 2008 21:15:23 +0000
Subject: Re: [PATCH] sparc: get leo framebuffer working
Message-Id: <20080610.141523.25824091.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4849CC85.2040207@earthlink.net>
In-Reply-To: <4849CC85.2040207@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 06 Jun 2008 19:47:17 -0400

> This patch fixes several issues:
>     Use the right openprom device name so the driver is actually loaded.
>     Fix a crash due to unitialized info->pseudo_palette.
>     Put the framebuffer in the proper mode for software rendering.
>     checkpatch cleanups.
> 
> Hardware acceleration was removed when the driver was rewritten
> for the new framebuffer API in 2003. Software rendering requires
> a different framebuffer access mode but that wasn't changed.  The
> driver now works again but is slow.  The proper fix is to reintroduce
> hardware acceleration.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied, thanks a lot for making this driver work Robert!
