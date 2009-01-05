From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jan 2009 08:07:29 +0000
Subject: Re: [PATCH] sparc: Clean arch-specific code in prom_common.c
Message-Id: <20090105.000729.96111745.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49601548.509@gmail.com>
In-Reply-To: <49601548.509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 4 Jan 2009 09:51:12 +0100

> On Sun, Jan 04, 2009 at 12:47:52PM +1100, Julian Calaby wrote:
> > sparc: Clean arch-specific code in prom_common.c
> > 
> > prom_nextprop() and prom_firstprop() have slightly different calling 
> > conventions in 32 and 64 bit SPARC.
> > 
> > prom_common.c uses a ifdef guard to ensure that these functions are 
> > called correctly.
> > 
> > Adjust code to eliminate this ifdef by using a calling convention that 
> > is compatible with both 32 and 64 bit SPARC.
> > 
> > Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
> 
> Looks good.
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Looks good to me too, applied.

Thanks everyone.
