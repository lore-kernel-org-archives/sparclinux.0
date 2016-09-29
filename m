From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Sep 2016 04:51:55 +0000
Subject: Re: [PATCH] Sparc/prom/ranges.c cosmetic improvement
Message-Id: <20160929045155.GB30814@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160928214625.GA24725@netmonk.localdomain>
In-Reply-To: <20160928214625.GA24725@netmonk.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Sep 28, 2016 at 11:46:25PM +0200, netmonk@netmonk.org wrote:
> Following Linux Coding Style documentation, removed, added some spaces 
> to improve compliance to the formating standard.
> 
> Signed-of-by: Netmonk <netmonk@netmonk.org>
> 
> 

> >From 276b83b74716cbd39c6c72428c6e385881b089e7 Mon Sep 17 00:00:00 2001
> From: netmonk <netmonk@netmonk.org>
> Date: Wed, 28 Sep 2016 23:26:33 +0200
> Subject: [PATCH]  Cosmetic improvement in arch/sparc/prom/ranges.c

Please fix subject as well.
prefix all patches with "sparc: what you did".

Use sparc: - for patches touching both 32 and 64 bit code.
Use sparc32: - for patches touching only 32 bit code.
Use sparc64: - for patches touching only 64 bit code.

	Sam
