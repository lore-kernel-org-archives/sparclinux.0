From: David Miller <davem@davemloft.net>
Date: Wed, 04 Apr 2012 07:29:18 +0000
Subject: Re: [PATCH] serial/sunzilog: fix keyboard on SUN SPARCstation
Message-Id: <20120404.032918.2152705331622872934.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404072807.GA10041@merkur.ravnborg.org>
In-Reply-To: <20120404072807.GA10041@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 4 Apr 2012 09:28:07 +0200

>>From 360d177dd8c19f23a26371d4e9337a46a1cde779 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 4 Apr 2012 09:00:11 +0200
> Subject: [PATCH] serial/sunzilog: fix keyboard on SUN sparcstation
> 
> The keyboard on my SUN SPARCstation 5 no longer worked.
> 
>     The culprint was: d4e33fac2408d37f7b52e80ca2a89f9fb482914f
>     ("serial: Kill off NO_IRQ")
> 
> Fix up logic for no irq / irq so the keyboard works again.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> 
> I assume the easy way is to channel this in via the sparc tree.
> The bug was introduced in the merge window - so this is not a stable candidate.

Yep, I'll apply this, thanks Sam.
