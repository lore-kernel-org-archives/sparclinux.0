From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 18 Oct 2017 13:14:27 +0000
Subject: Re: [PATCH] video: fbdev: remove dead igafb driver
Message-Id: <62038aaa-7245-25be-a5db-7253eaad5cc3@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <CGME20171018125650epcas1p40c181757104f1cb73b1a41596a63b465@epcas1p4.samsung.com>
 <1709588.9HyCXSDUyM@amdc3058>
In-Reply-To: <1709588.9HyCXSDUyM@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Bhumika Goyal <bhumirks@gmail.com>

Hi Bartlomiej!

On 10/18/2017 02:56 PM, Bartlomiej Zolnierkiewicz wrote:
> igafb driver hasn't compiled since at least kernel v2.6.34 as
> commit 6016a363f6b5 ("of: unify phandle name in struct device_node")
> missed updating igafb.c to use dp->phandle instead of dp->node.
Would it take a lot of work to port the driver to the new interface?

I'm not sure which SPARC machines use this particular framebuffer, but
my plans are to fix up all these old framebuffer drivers. I have already
received several Amiga (Zorro) graphics cards for testing the updated
drivers on Amiga.

It could be that I actually have this particular SPARC framebuffer in
my hardware collection.

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
