From: David Miller <davem@davemloft.net>
Date: Sat, 19 May 2012 22:29:22 +0000
Subject: Re: [PATCH] sparc32: add ucmpdi2
Message-Id: <20120519.182922.1864622054066241040.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120519095830.GA4813@merkur.ravnborg.org>
In-Reply-To: <20120519095830.GA4813@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 May 2012 11:58:30 +0200

>>From 44be8ae622596463a6e64542ce8580567cf78f15 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 19 May 2012 11:54:11 +0200
> Subject: [PATCH] sparc32: add ucmpdi2
> 
> Based on copy from microblaze add ucmpdi2 implementation.
> This fixes build of niu driver which failed with:
> 
> drivers/built-in.o: In function `niu_get_nfc':
> niu.c:(.text+0x91494): undefined reference to `__ucmpdi2'
> 
> This driver will never be used on a sparc32 system,
> but patch added to fix build breakage with all*config builds.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

I applied this and pushed it out.

But I just noticed that since you export a symbol from this
file, we have to add it to obj-y instead of lib-y so I'll
commit a follow-on patch which does that.
