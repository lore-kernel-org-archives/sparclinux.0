From: David Miller <davem@davemloft.net>
Date: Wed, 08 Jul 2015 21:55:06 +0000
Subject: Re: [PATCH v2] rhashtable: fix for resize events during table walk
Message-Id: <20150708.145506.1343225462680114617.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1436190680-21887-1-git-send-email-phil@nwl.cc>
In-Reply-To: <1436190680-21887-1-git-send-email-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: phil@nwl.cc
Cc: tgraf@suug.ch, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au, daniel@iogearbox.net, geert@linux-m68k.org, mroos@linux.ee

From: Phil Sutter <phil@nwl.cc>
Date: Mon,  6 Jul 2015 15:51:20 +0200

> If rhashtable_walk_next detects a resize operation in progress, it jumps
> to the new table and continues walking that one. But it misses to drop
> the reference to it's current item, leading it to continue traversing
> the new table's bucket in which the current item is sorted into, and
> after reaching that bucket's end continues traversing the new table's
> second bucket instead of the first one, thereby potentially missing
> items.
> 
> This fixes the rhashtable runtime test for me. Bug probably introduced
> by Herbert Xu's patch eddee5ba ("rhashtable: Fix walker behaviour during
> rehash") although not explicitly tested.
> 
> Fixes: eddee5ba ("rhashtable: Fix walker behaviour during rehash")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Applied and queued up for -stable, thanks.
