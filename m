From: Tejun Heo <tj@kernel.org>
Date: Tue, 26 Aug 2014 18:16:20 +0000
Subject: Re: [PATCH 31/35] [PATCH 31/36] sparc: Replace __get_cpu_var uses
Message-Id: <20140826181620.GN31659@mtj.dyndns.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140817173023.439660246@linux.com>
 <20140817173037.730576191@linux.com>
In-Reply-To: <20140817173037.730576191@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Lameter <cl@linux.com>
Cc: akpm@linuxfoundation.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Sun, Aug 17, 2014 at 12:30:54PM -0500, Christoph Lameter wrote:
> __get_cpu_var() is used for multiple purposes in the kernel source. One of
> them is address calculation via the form &__get_cpu_var(x).  This calculates
> the address for the instance of the percpu variable of the current processor
> based on an offset.
> 
> Other use cases are for storing and retrieving data from the current
> processors percpu area.  __get_cpu_var() can be used as an lvalue when
> writing data or on the right side of an assignment.
...
> Cc: sparclinux@vger.kernel.org
> Acked-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Christoph Lameter <cl@linux.com>

(Please disregard the ones I posted for v1 of the patch series)

Applied to percpu/for-3.18-consistent-ops.  Please let me know if this
patch should be routed differently.  Note that this patch was to be
applied to percpu/for-3.17 but delayed due to build issues caused by
cpumask_var_t.

Thanks.

-- 
tejun
