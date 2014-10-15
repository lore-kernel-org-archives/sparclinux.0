From: Meelis Roos <mroos@linux.ee>
Date: Wed, 15 Oct 2014 08:04:49 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <alpine.LRH.2.11.1410151059520.8050@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20141013235219.GA11191@js1304-P5Q-DELUXE> <20141013.200416.641735303627599182.davem@davemloft.net> <alpine.LRH.2.11.1410150012001.11850@adalberg.ut.ee> <20141014.173246.921084057467310731.davem@davemloft.net>
In-Reply-To: <20141014.173246.921084057467310731.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

> > My only other current sparc64 problems that I am seeing - V210/V440 die 
> > during bootup if compiled with gcc 4.9 and V480 dies with FATAL 
> > exceptions during bootups since previous kernel release. Maybe also 
> > exit_mmap warning - I do not know if they have been fixed, I see them 
> > rarely.
> 
> The gcc-4.9 case is interesting, are you saying that a gcc-4.9 compiled
> kernel works fine on other systems?

Yes, all USII based systems work fine with Debian gcc-4.9, as does 
T2000. Of USIII* systems, V210 and V440 exhibit the boot hang with 
gcc-4.9 and V480 crashes wit FATAL exception during boot that is 
probably earlier than the gcc boot hang so I do not know about V480 and 
gcc-4.9. V240 not tested because of fan failures, V245 is in the queue 
for setup but not tested so far.

-- 
Meelis Roos (mroos@linux.ee)
