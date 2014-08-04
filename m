From: David Miller <davem@davemloft.net>
Date: Mon, 04 Aug 2014 23:04:23 +0000
Subject: Re: [PATCH] Fix BREAK handling in sunsab serial driver
Message-Id: <20140804.160423.109000969934940193.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271519.22272.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271519.22272.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 3 Aug 2014 14:25:35 +0200

> IIRC it was a null pointer dereference in perf_event_print_debug(),
> but I am not quite sure, as we quickly disabled this call to continue
> working (getting BREAK on the serial console to work was top priority
> then). We will have to wait for Norman to retrieve this information -
> he is currently on vacation, however, so it will take another week.

If it's in perf_event_print_debug() there isn't much to check.

sparc_pmu is derefernced in the loops, but the first thing this
function does is check it against NULL and return immediately
if it is NULL.

pcr_ops is dereferenced also, but pcr_ops should never be NULL
if sparc_pmu is not NULL.

Hmmm... that's setup by pcr_arch_init() which I only see being
invoked by smp_cpus_done().

Is this a uniprocessor build?
