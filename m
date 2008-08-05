From: David Miller <davem@davemloft.net>
Date: Tue, 05 Aug 2008 01:43:16 +0000
Subject: [GIT]: Sparc
Message-Id: <20080804.184316.193691329.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Besides a few bug fixes, the main bit in here is changing
sparc64's SMP code to take advantage of the &cpumask_of_cpu()
stuff we have now.

With one exception, the sparc64 cross-call code will now only work
with constant cpumask_t pointers, rather than using cpumask_t local
variables.

That exception is arch_send_call_function_ipi()' "mask" argument.  I
would really like to see that interface pass in a constant cpumask_t
pointer too.

As I found when transforming the sparc64 code, the only way to get rid
of these function local cpumask_t variables is to put the "is it
online?" and "is it current cpu?" handling down in the cross-call
dispatch code itself.  I think the generic SMP helper code should do
the same as well.

In fact the current:

	cpu = smp_processor_id();
	allbutself = cpu_online_map;
	cpu_clear(cpu, allbutself);
	cpus_and(mask, mask, allbutself);

construct in smp_call_function_mask() is very inefficient.  Better
would be something like:

	cpu = smp_processor_id();
	cpu_clear(cpu, mask);
	cpus_and(mask, mask, cpu_online_map);

which allows to eliminate the allbutself local variable entirely.

Please pull, thanks a lot!

The following changes since commit 8f616cd5249e03c9e1b371623d85e76d4b86bbc1:
  Linus Torvalds (1):
        Merge branch 'for_linus' of git://git.kernel.org/.../tytso/ext4

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (13):
      sparc64: Need to disable preemption around smp_tsb_sync().
      sparc64: Use function pointer for cross-call sending.
      sparc64: Use xcall_deliver() consistently.
      sparc64: Use cpumask_t pointers and for_each_cpu_mask_nr() in xcall_deliver.
      sparc64: Call xcall_deliver() directly in some cases.
      sparc64: Directly call xcall_deliver() in smp_start_sync_tick_client.
      sparc64: Make smp_cross_call_masked() take a cpumask_t pointer.
      sparc64: Always allocate the send mondo blocks, even on non-sun4v.
      sparc64: Make all xcall_deliver's go through common helper function.
      sparc64: Disable local interrupts around xcall_deliver_impl() invocation.
      sparc64: Build cpu list and mondo block at top-level xcall_deliver().
      sparc64: Kill error_mask from hypervisor_xcall_deliver().
      sparc64: Remove all cpumask_t local variables in xcall dispatch.

Huang Weiyi (1):
      arch/sparc64/kernel/signal.c: removed duplicated #include

 arch/sparc64/kernel/irq.c    |   19 +++-
 arch/sparc64/kernel/signal.c |    1 -
 arch/sparc64/kernel/smp.c    |  292 +++++++++++++++++++++---------------------
 arch/sparc64/mm/tsb.c        |    5 +-
 4 files changed, 166 insertions(+), 151 deletions(-)
