From: David Miller <davem@davemloft.net>
Date: Thu, 24 Dec 2015 16:43:21 +0000
Subject: Re: [PATCH 2/2] sparc64: Perf should save/restore fault info
Message-Id: <20151224.114321.97836338167056683.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450844167-7327-2-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450844167-7327-2-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 22 Dec 2015 21:16:07 -0700

> There have been several reports of random processes being killed with
> a bus error or segfault during userspace stack walking in perf.  One
> of the root causes of this problem is an asynchronous modification to
> thread_info fault_address and fault_code, which stems from a perf
> counter interrupt arriving during kernel processing of a "benign"
> fault, such as a TSB miss. Since perf_callchain_user() invokes
> copy_from_user() to read user stacks, a fault is not only possible,
> but probable. Validity checks on the stack address merely cover up the
> problem and reduce its frequency.
> 
> The solution here is to save and restore fault_address and fault_code
> in perf_callchain_user() so that the benign fault handler is not
> disturbed by a perf interrupt.
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
> Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>

Applied.
