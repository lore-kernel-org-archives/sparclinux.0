From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 22 Oct 2020 11:17:00 +0000
Subject: Re: [sparc64] lockdep: Fix lockdep recursion - call trace
Message-Id: <20201022111700.GZ2651@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwQ_nvbGrzDzOjzt=R5x6yvsU4AujhpxXYs8cHFwoCjmA@mail.gmail.com>
 <20201022110015.GJ2594@hirez.programming.kicks-ass.net>
In-Reply-To: <20201022110015.GJ2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Thu, Oct 22, 2020 at 01:00:16PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 12:21:55PM +0300, Anatoly Pugachev wrote:
> > Hello!
> > 
> > Bisected the following linux calltrace after v5.9 :
> > 
> > [    8.650198] systemd[1]: Started Journal Service.
> > [    9.028125] ------------[ cut here ]------------
> > [    9.028171] WARNING: CPU: 11 PID: 499 at
> > net/netfilter/nf_tables_api.c:622 nft_chain_parse_hook+0x7c/0x360
> > [nf_tables]
> > [    9.028185] Modules linked in: nf_tables nfnetlink sunrpc ip_tables
> > x_tables ipv6 crc_ccitt autofs4 ext4 crc16 mbcache jbd2 raid10 raid456
> > async_raid6_recov async_mem
> > cpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath
> > linear md_mod crc32c_sparc64
> > [    9.028243] CPU: 11 PID: 499 Comm: nft Tainted: G        W
> > 5.9.0-rc8-00209-gbaffd723e44d #111
> > [    9.028255] Call Trace:
> > [    9.028269] [<00000000004727e8>] __warn+0xa8/0x120
> > [    9.028278] [<0000000000472c20>] warn_slowpath_fmt+0x34/0x74
> > [    9.028291] [<00000000100c19fc>] nft_chain_parse_hook+0x7c/0x360 [nf_tables]
> 
> > commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> 
> What's unexpected.. while I just queued a another fix for that commit:
> 
>   https://lkml.kernel.org/r/20201022103028.GC2611@hirez.programming.kicks-ass.net
> 
> I don't think that explains this WARN. Let me go prod at it.

This looks like lockdep_is_held() encounters an incremented recursion
count and returns 1, which in this case will trigger the WARN.

But that would mean we're leaking a recursion count somewhere... do you
have CONFIG_DEBUG_PREEMPT enabled?
