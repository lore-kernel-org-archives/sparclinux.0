From: Li Zefan <lizf@cn.fujitsu.com>
Date: Thu, 18 Mar 2010 06:39:13 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <4BA1CA91.2060004@cn.fujitsu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318044930.GC5045@nowhere> <20100317.232648.59697287.davem@davemloft.net>
In-Reply-To: <20100317.232648.59697287.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org

David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Thu, 18 Mar 2010 05:49:33 +0100
> 
>> While using the lock events through perf in a sparc box, I can see
>> the following message repeated many times:
>>
>> 	Kernel unaligned access at TPC[49357c] perf_trace_lock_acquire+0xb4/0x180
>>
>> It actually hangs the box as the messages are sent to a serial console.
>>
>> When used with perf, the trace events use a per cpu buffer allocated
>> in kernel/trace/trace_event_perf.c, and the allocation appears to return
>> a misaligned percpu pointer. It is aligned to 4 while it seems it
>> requires to be aligned to 8.
> 
> Thanks I'll take a look at this.
> 
> RAW locks (both rwlocks and spinlocks) on sparc64 are 4-bytes
> in size, maybe some piece of code is assuming that locks
> are cpu word sized.
> 
> Where is perf_trace_lock_acquire() I can't find it in Linus's
> tree?  Does it get created by some crazy macro expansion?
> 

Yes, it's expanded by some crazy macro in include/trace/ftrace.h..

In linus' tree, it's called ftrace_profile_lock_acquire(), and it's
renamed to perf_trace_lock_acquire() in -tip tree by commit
97d5a22005f38057b4bc0d95f81cd26510268794.

#undef DECLARE_EVENT_CLASS
#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)  \
static notrace void                                                     \
ftrace_profile_templ_##call(struct ftrace_event_call *event_call,       \
                            proto)                                      \
{                                                                       \
        struct ftrace_data_offsets_##call __maybe_unused __data_offsets;\
        struct ftrace_raw_##call *entry;                                \
        u64 __addr = 0, __count = 1;                                    \
        unsigned long irq_flags;                                        \
        int __entry_size;                                               \
        int __data_size;                                                \
        int rctx;                                                       \
                                                                        \
...
}
