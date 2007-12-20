From: Emanuele Rocca <ema@linux.it>
Date: Thu, 20 Dec 2007 20:19:01 +0000
Subject: Re:  No dma_sync_* during pci_probe? (Sparc, post 2.6.22
Message-Id: <20071220201901.GA30969@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <4767A323.7090205@s5r6.in-berlin.de> <20071218.142956.26529678.davem@davemloft.net> <476947C1.2010405@s5r6.in-berlin.de> <20071220.004033.75315225.davem@davemloft.net>
In-Reply-To: <20071220.004033.75315225.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: stefanr@s5r6.in-berlin.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net

* David Miller <davem@davemloft.net>, [2007-12-20  0:40 -0800]:
>  The problem is that I created indirection that was totally unused, the
>  operation vectors members for these cases thus didn't get filled in,
>  and we OOPS trying to call NULL pointers as functions :-)
>  
>  This should fix the crash:

It does, tested on a Sun Blade 2000.

Thank you David.
ciao,
    ema
