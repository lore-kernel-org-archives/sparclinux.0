From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Sat, 10 Mar 2007 16:31:09 +0000
Subject: Re: [PATCH] Fix sparc TIF_USEDFPU flag atomicity
Message-Id: <20070310163109.GA5901@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20070310081743.GC23144@Krystal> <20070310082646.GC2994@holomorphy.com> <20070310.002944.115909724.davem@davemloft.net> <20070310105903.GA8915@holomorphy.com>
In-Reply-To: <20070310105903.GA8915@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

* William Lee Irwin III (wli@holomorphy.com) wrote:
> On Sat, 10 Mar 2007 00:26:46 -0800, William Lee Irwin III <wli@holomorphy.com> wrote:
> >> Oh dear. Could we bit a bit more idiomatic here? For instance,
> >> something like:
> 
> On Sat, Mar 10, 2007 at 12:29:44AM -0800, David Miller wrote:
> > Ok I pulled the sparc32 patch back out until there is some
> > consensus here :)
> 
> It's just a minor touch-up. If Mathieu is okay with it, I'd rather
> leave him as the author and just send along an Acked-by: with it.
> I'm not terribly attached to it, either. I just choked on my soda
> when I saw set_ti_thread_flag(task_thread_info(fpt), TI_USEDFPU)
> etc. go by. (Which reminds me, I really need to figure out how to
> consolidate the UP and SMP cases for all this.)
> 
> 
> -- wli

Hello,

William's implementation is indeed neater than mine. So the consensus
goes to his patch as far as I'm concerned.

Mathieu

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
