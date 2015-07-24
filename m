From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 24 Jul 2015 01:17:43 +0000
Subject: Re: [PATCH v3 7/8] perf: Define PMU_TXN_READ interface
Message-Id: <20150724011743.GA5847@us.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-8-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150716222015.GO3644@twins.programming.kicks-ass.net>
 <20150722015045.GA24420@us.ibm.com>
 <20150722055503.GO25159@twins.programming.kicks-ass.net>
 <20150722231916.GA1863@us.ibm.com>
 <20150723080435.GE25159@twins.programming.kicks-ass.net>
In-Reply-To: <20150723080435.GE25159@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org

Peter Zijlstra [peterz@infradead.org] wrote:
| On Wed, Jul 22, 2015 at 04:19:16PM -0700, Sukadev Bhattiprolu wrote:
| > Peter Zijlstra [peterz@infradead.org] wrote:
| > | I've not woken up yet, and not actually fully read the email, but can
| > | you stuff the entire above chunk inside the IPI?
| > | 
| > | I think you could then actually optimize __perf_event_read() as well,
| > | because all these events should be on the same context, so no point in
| > | calling update_*time*() for every event or so.
| > | 
| > 
| > Do you mean something like this (will move the rename to a separate
| > patch before posting):
| 
| More like so.. please double check, I've not even had tea yet.

Yeah, I realized I had ignored the 'event->cpu' spec.
Will try this out. Thanks,

Sukadev

