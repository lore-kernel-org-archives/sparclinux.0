From: mroos@linux.ee
Date: Tue, 14 Oct 2014 21:19:36 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <alpine.LRH.2.11.1410150012001.11850@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20141012.132012.254712930139255731.davem@davemloft.net> <alpine.LRH.2.11.1410132320110.9586@adalberg.ut.ee> <20141013235219.GA11191@js1304-P5Q-DELUXE> <20141013.200416.641735303627599182.davem@davemloft.net>
In-Reply-To: <20141013.200416.641735303627599182.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

> > I'd like to know that your another problem is related to commit
> > bf0dea23a9c0 ("mm/slab: use percpu allocator for cpu cache").  So,
> > if the commit is reverted, your another problem is also gone
> > completely?
> 
> The other problem has been present forever.

Umm? I am afraid I have been describing it badly. This random 
SIGBUS+SIGSEGV problem is new - I have not seen it before.

I have been able to do kernel compiles for years on sparc64 (modulo 
specific bugs in specific configurations) and 3.17 + start/end swap 
patch seems also stable for most machine. With yesterdays git + align 
patch, it dies with SIGBUS multiple times during compilation so it's a 
new regression for me.

Will try reverting that commit tomorrow.

My only other current sparc64 problems that I am seeing - V210/V440 die 
during bootup if compiled with gcc 4.9 and V480 dies with FATAL 
exceptions during bootups since previous kernel release. Maybe also 
exit_mmap warning - I do not know if they have been fixed, I see them 
rarely.

-- 
Meelis Roos (mroos@linux.ee)
