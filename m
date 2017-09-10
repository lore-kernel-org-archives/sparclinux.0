From: David Miller <davem@davemloft.net>
Date: Sun, 10 Sep 2017 03:17:01 +0000
Subject: Re: [PATCH v2] sparc64: Handle additional cases of no fault loads
Message-Id: <20170909.201701.349814412927744923.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1504910061-248242-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504910061-248242-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri,  8 Sep 2017 16:34:21 -0600

> Load instructions using ASI_PNF or other no-fault ASIs should not
> cause a SIGSEGV or SIGBUS.
> 
> A garden variety unmapped address follows the TSB miss path, and when
> no valid mapping is found in the process page tables, the miss handler
> checks to see if the access was via a no-fault ASI.  It then fixes up
> the target register with a zero, and skips the no-fault load
> instruction.
> 
> But different paths are taken for data access exceptions and alignment
> traps, and these do not respect the no-fault ASI. We add checks in
> these paths for the no-fault ASI, and fix up the target register and
> TPC just like in the TSB miss case.
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>

Applied, but we really should use a common set of instruction decode
macros, like the ones we use to create instructions in the eBPF JIT
for example.

So instead of having the explain every opcode field in comments, which
is really a redundant waste of space, we would say:

	/* If load/store instruction and accesses alternate address
	 * space...
	 */
	if (OP(insn) = 3 && (OP3(insn) & 0x10) != 0)) {

Or something like that.

