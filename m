From: Atish Patra <atish.patra@oracle.com>
Date: Wed, 06 Dec 2017 01:41:47 +0000
Subject: Re: [PATCH] sparc64: Set possible and present masks based on nr_cpu_ids
Message-Id: <839f3177-7869-1e4c-2547-bc684210e8f7@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
In-Reply-To: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Thomas,
I am looking at a spinlock bad magic issue in timer code on a legacy 
sparc machine.

0eeda71b (timer: Replace timer base by a cpu index)
As per my understanding, the above patch assumes there is always a cpu 0 
and that timer to CPU0 should be assigned statically to avoid 
boot_tvec_base logic.
DEFINE_TIMER macro seems to initialize the flags to 0 and the commit 
text also points to that.
Please let me know if I missed something.

We observed the spinlock bad magic with legacy sun4u machines which have 
sparse numbered cpus and does not have cpu0.
We may be wrong but our investigation pointed out that per-cpu 
timer_base structure for cpu 0 is not initialized leading invalid
magic value. console_timer seems to be statically assigned to cpu0 in 
this case.

-----------------------------------part of the relevant 
dmesg---------------------------------------------------------------------------
[  179.005589] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 
0x5c4093a7d1, max_idle_ns: 440795210635 ns
[  179.109253] clocksource: mult[2800000] shift[24]
[  179.148828] clockevent: mult[66666666] shift[32]
[  179.190350] BUG: spinlock bad magic on CPU#6, swapper/6/0
[  179.190392]  lock: timer_bases+0x0/0x2180, .magic: 00000000, .owner: 
<none>/-1, .owner_cpu: 0
[  179.190409] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 4.8.0-dirty #92
[  179.190416] Call Trace:
[  179.190445]  [00000000004abe60] spin_dump+0x60/0xa0
[  179.190460]  [00000000004abeb8] spin_bug+0x18/0x40
[  179.190476]  [00000000004ac024] do_raw_spin_lock+0x24/0x120
[  179.190510]  [00000000008c6088] _raw_spin_lock_irqsave+0x48/0x60
[  179.190530]  [00000000004bfd08] lock_timer_base.isra.13+0x68/0xc0
[  179.190545]  [00000000004c07cc] mod_timer+0xcc/0x2c0
[  179.190562]  [0000000000a6928c] con_init+0x120/0x28c
[  179.190575]  [0000000000a68a4c] console_init+0x1c/0x38
[  179.190592]  [0000000000a4e92c] start_kernel+0x31c/0x41c
[  179.190607]  [0000000000a500fc] start_early_boot+0x274/0x284
[  179.190622]  [00000000008bed2c] tlb_fixup_done+0x4c/0x60
[  179.190632]  [0000000000000000]           (null)
---------------------------------------------------------------------------------------------------------------------------------------------------------------

I tried to avoid this by setting the cpu0 in cpu possible map just for 
sun4u.
Here is upstream discussion for my patch:
http://www.spinics.net/lists/sparclinux/msg19144.html
I agree that this is a hack. I would prefer any other elegant approach 
to solve this issue.

Regards,
Atish

On 11/27/2017 10:39 AM, Atish Patra wrote:
>
>
> On 11/19/2017 12:54 AM, David Miller wrote:
>> So, this is fixing a regression, right?
> Yes.
>> If so, you need to provide a proper "Fixes: " tag identifying
>> the commit that introduced the bug.
> Sure. I will add that in v2.
>> I'm also finding it hard to believe that forcing cpu 0 as a possible
>> cpu is required.  Have you considered contacting the timer subsystem
>> maintainers and asked them to remove this assumption?
> I will check with the timer maintainers.
>
> Regards,
> Atish
>> Thank you.
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

