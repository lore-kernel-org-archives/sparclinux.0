From: "David S. Miller" <davem@redhat.com>
Date: Mon, 02 Feb 2004 18:22:57 +0000
Subject: Re: [sparc32] Copy full soft PMD in fault handler
Message-Id: <20040202102257.24b70263.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040202094347.GB22498@foobazco.org>
In-Reply-To: <20040202094347.GB22498@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2 Feb 2004 01:43:47 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> sparc_do_fault assumes that pmd_val(*pmd) = pmd_val(*pmd_k) will
> duplicate a PMD entry.  With large soft-PMDs this doesn't work.
> 
> Is this ok?

I think this patch is just fine.

> The comment in the i386 handler "Do _not_
> use "tsk" here. We might be inside an interrupt in the middle of a
> task switch.." doesn't make me feel too good about this function's
> health and well-being either, since we use tsk.

I think it does not apply to sparc, on sparc we disable interrupts during
the context switch so that it "appears" atomic.  But actually you should
change it over to use init_mm.pgd just like other platforms merely for
consistency.

