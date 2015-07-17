From: Thomas Graf <tgraf@suug.ch>
Date: Fri, 17 Jul 2015 08:04:56 +0000
Subject: Re: 4.1 regression in resizable hashtable tests
Message-Id: <20150717080456.GA13814@pox.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507011259180.4092@math.ut.ee>
 <20150702123130.GA20843@pox.localdomain>
 <alpine.LRH.2.11.1507022208200.28236@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1507022208200.28236@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Daniel Borkmann <daniel@iogearbox.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On 07/02/15 at 10:09pm, Meelis Roos wrote:
> [   33.425061] Running rhashtable test nelem=8, max_sizee536, shrinking=0
> [   33.425154] Test 00:
> [   33.534470]   Adding 50000 keys
> [   34.743553] Info: encountered resize
> [   34.743698] Info: encountered resize
> [   34.743838] Info: encountered resize
> [   34.744057] Info: encountered resize
> [   34.744430] Info: encountered resize
> [   34.745139] Info: encountered resize
> [   34.746441] Info: encountered resize
> [   34.749055] Info: encountered resize
> [   34.754469] Info: encountered resize
> [   34.764836] Info: encountered resize
> [   34.785696] Info: encountered resize
> [   34.827448] Info: encountered resize
> [   34.896936]   Traversal complete: countedI993, nelemsP000, entriesP000, table-jumps
> [   34.897056] Test failed: Total count mismatch ^^^

I do see count mismatches as well due to the design of the walker
which restarts and thus sees certain entries multiple times.

Do you have this commit as well?

Author: Phil Sutter <phil@nwl.cc>
Date:   Mon Jul 6 15:51:20 2015 +0200

    rhashtable: fix for resize events during table walk
