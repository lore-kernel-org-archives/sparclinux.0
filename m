From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 10 Mar 2007 10:59:03 +0000
Subject: Re: [PATCH] Fix sparc TIF_USEDFPU flag atomicity
Message-Id: <20070310105903.GA8915@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070310081743.GC23144@Krystal> <20070310082646.GC2994@holomorphy.com> <20070310.002944.115909724.davem@davemloft.net>
In-Reply-To: <20070310.002944.115909724.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mathieu.desnoyers@polymtl.ca, akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sat, 10 Mar 2007 00:26:46 -0800, William Lee Irwin III <wli@holomorphy.com> wrote:
>> Oh dear. Could we bit a bit more idiomatic here? For instance,
>> something like:

On Sat, Mar 10, 2007 at 12:29:44AM -0800, David Miller wrote:
> Ok I pulled the sparc32 patch back out until there is some
> consensus here :)

It's just a minor touch-up. If Mathieu is okay with it, I'd rather
leave him as the author and just send along an Acked-by: with it.
I'm not terribly attached to it, either. I just choked on my soda
when I saw set_ti_thread_flag(task_thread_info(fpt), TI_USEDFPU)
etc. go by. (Which reminds me, I really need to figure out how to
consolidate the UP and SMP cases for all this.)


-- wli
