From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 21 Apr 2007 21:18:06 +0000
Subject: Re: Soft Lockup on sun4c
Message-Id: <Pine.LNX.4.61.0704212123320.24824@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sat, 21 Apr 2007, Jan Engelhardt wrote:

>
> On Apr 21 2007 20:33, Mark Fortescue wrote:
>>
>> I will check that if I ever get far enough. The system locks up in
>> kernel_exec of the initail process /sbin/bash.static
>> (init=/sbin/bash.static).
>
> Perhaps try sash if it is installed.
>

Linux-2.6.14.3 works. Linux-2.6.15.6 fails.

sash starts up with Linux-2.6.15.6 but ls fails:
BUG: soft lockup detected on CPU#0!
PSR: 004010c0 PC: f00fba04 NPC: f00fba08 Y: a4000000    Not tainted
PC: <__memcpy+0x208/0x640>
%G: 00000000 00000040  00000000 00000000  00000000 00000000  ff000000 00000040
%O: ff001de0 f0256f38  00000040 0000008c  00000060 f00fb7a0  ff001d18 f0062204
RPC: <__handle_mm_fault+0x64/0x8ac>
%L: ff001da0 000010a1  88b00e6a f0256ef8  00000010 00000000  00000000 0000000a
%I: f0257dc8 f0242698  efb9f6f0 00000000  00000030 f00fb7d0  ff001de8 f001ddb8

This looks like there may be an issue the memory allocation systems.

-more /proc/meminfo:
<< /proc/meminfo >>
MemTotal:        37996 kB
MemFree:         36512 kB
Buffers:             0 kB
Cached:            544 kB
SwapCached:          0 kB
Active:             60 kB
Inactive:          540 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        37996 kB
LowFree:         36512 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            252 kB
Slab:              652 kB
CommitLimit:     18996 kB
Committed_AS:      256 kB
PageTables:         12 kB
VmallocTotal:    22528 kB
VmallocUsed:         0 kB
VmallocChunk:    22528 kB
--More--
BUG: soft lockup detected on CPU#0!
PSR: 004010c6 PC: f0012258 NPC: f001225c Y: 7d000000    Not tainted
PC: <ret_trap_continue+0x0/0x44>
%G: 00000000 004010a6  00000008 00000000  f0257dfc 00000000  ff000000 00000040
%O: f0252698 00002000  e0004400 00000000  00000000 00000050  ff001f50 f0012450
RPC: <ret_trap_user_stack_is_bolixed+0x14/0x24>
%L: 00401080 00045374  00045378 00000002  00000004 e0004000  00000000 f0066078
%I: 00000000 00002000  e0004400 00000000  00000000 00000050  efa8a558 00033d70

>> Is there a setting to make L1-A enabled by default?
>
> Not that I know of any boot-time option, but there is always the source code.
> BTW, stop_a is enabled by default (which bugs me a bit since it is disabled
> by default when aurora is up and running unless you set the sysctl somewhere.)
>
> 21:33 ichi:../sparc64/kernel > grep -r stop_a .
> ./setup.c:int stop_a_enabled = 1;
> (same for sparc32)
>

stop_a_enabled is set in arch/sparc/kernel/setup.c as per the sparc64 
setup.

I see no code that clears it however I have had problems with 
drivers/serial/sunzilog.c in 2.6.20.7 (it was enabling interrupts before 
setting up the interrupt handler which caused my Sparcstation to panic).

I will add in some debug statements to the driver to see if I am getting a 
BREAK condition and the check that interrupts are now working incase there 
still errors to be fixed.

I will send a patch in for the sunzilog driver when I get a 2.6.20.7 
kernel that gets to a shell and has a working L1-A and serial line BREAK 
condition.

>
> Jan
> -- 
>
