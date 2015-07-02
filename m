From: Thomas Graf <tgraf@suug.ch>
Date: Thu, 02 Jul 2015 12:31:30 +0000
Subject: Re: 4.1 regression in resizable hashtable tests
Message-Id: <20150702123130.GA20843@pox.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507011259180.4092@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1507011259180.4092@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Daniel Borkmann <daniel@iogearbox.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On 07/01/15 at 01:21pm, Meelis Roos wrote:
> This is 4.1 on sparc64 - one of my boxes that happens to have most 
> runtime test left on from some debugging effort. In 4.0 it was fine, 4.1 
> gives this in dmesg:
> 
> [   31.898697] Running resizable hashtable tests...
> [   31.898915]   Adding 2048 keys
> [   31.952911]   Traversal complete: counted, nelems 48, entries 48
> [   31.953004] Test failed: Total count mismatch ^^^
> [   32.022676]   Traversal complete: counted, nelems 48, entries 48
> [   32.022788] Test failed: Total count mismatch ^^^
> [   32.022828]   Deleting 2048 keys

Thanks for the report. I think this is already fixed. Can you try with the
following commit:

commit 246b23a7695bd5a457aa51a36a948cce53d1d477
Author: Thomas Graf <tgraf@suug.ch>
Date:   Thu Apr 30 22:37:44 2015 +0000

    rhashtable-test: Use walker to test bucket statistics

    As resizes may continue to run in the background, use walker to
    ensure we see all entries. Also print the encountered number
    of rehashes queued up while traversing.

    This may lead to warnings due to entries being seen multiple
    times. We consider them non-fatal.

    Signed-off-by: Thomas Graf <tgraf@suug.ch>
    Signed-off-by: David S. Miller <davem@davemloft.net>
