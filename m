From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 01 Sep 2015 22:11:53 +0000
Subject: Re: [PATCH v5 1/8] perf: Add a flags parameter to pmu txn interfaces
Message-Id: <20150901221153.GB4158@us.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1439534981-7937-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150901103859.GP19282@twins.programming.kicks-ass.net>
In-Reply-To: <20150901103859.GP19282@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org

Peter Zijlstra [peterz@infradead.org] wrote:
| 
| when looking at this (I almost pressed A for apply) it occurred to me
| that we now keep double state, cpuhw->txn_flags and cpuhw->group_flag
| are basically the same thing.
| 
| Would not something like the below avoid this duplication?

Yes, it makes sense to drop the duplication. Will similarly drop the usage
of PERF_EVENT_TXN from other architectures too and try it out.

Thanks,

Sukadev

