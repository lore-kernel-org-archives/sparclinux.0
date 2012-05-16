From: Jiri Gaisler <jiri@gaisler.se>
Date: Wed, 16 May 2012 12:55:48 +0000
Subject: Re: [RFC PATCH] sparc32,leon: always include leon code in build
Message-Id: <4FB3A3D4.7080902@gaisler.se>
List-Id: <sparclinux.vger.kernel.org>
References: <20120514202951.GA4439@merkur.ravnborg.org>
In-Reply-To: <20120514202951.GA4439@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Sam Ravnborg wrote:

> Konrad / Daniel - any inputs on why LEON uses a different ASI?
> As we uses this in head_32.S this is really annoying...

It is not difficult to change the MMU reg ASI from 0x19 to 0x4
(as defined in the SRMMU spec). However, all available LEON2/3/4
chips in production uses 0x19 due to a decision take about 10
years ago. ASI 4 was used for uncached access in the original
MMU-less LEON2, hence the choice to use 0x19. In current LEON3/4
cores, ASI 4 is no longer used, so 0x19 could easily be replaced
with 4. But removing the use of ASI 0x19 in the kernel will make
it incompatible with all present chips. I will change the LEON3/4
IP's to double map the MMU ASI to both 4 and 0x19, but then we have
to wait an other 10 years until the present chips are out of use
before we can remove 0x19 from the kernel ...

Jiri.


> 
> 	Sam
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
