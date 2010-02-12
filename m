From: David Miller <davem@davemloft.net>
Date: Fri, 12 Feb 2010 00:39:50 +0000
Subject: Re: parsic/sh/sparc tracehook breakage when tracing signals
Message-Id: <20100211.163950.206150918.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201002111910.50596.vapier@gentoo.org>
In-Reply-To: <201002111910.50596.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vapier@gentoo.org
Cc: linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, roland@redhat.com, linux-kernel@vger.kernel.org

From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 11 Feb 2010 19:10:47 -0500

> when i ported the Blackfin code to the tracehook framework, i copied a latent 
> bug from the sparc port.  trying to trace another process while handling 
> signals no longer worked (and subsequently broke some of the gdb tests).

What you seem to be missing is that on Sparc TIF_SINGLESTEP will never
be set, because it does not support hardware single step.

This thread flag is not even defined on that platform.
