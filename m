From: Meelis Roos <mroos@linux.ee>
Date: Mon, 22 Feb 2021 19:34:54 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <cde8e197-bad5-f239-6e6e-ed39eb3f7d53@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

>> 1. https://www.spinics.net/lists/sparclinux/msg25915.html
>> 2. https://www.spinics.net/lists/sparclinux/msg25917.html
> 
> I've looked at those and they don't contain the information I am interested in. I believe that stress-ng issues random opcodes in order to test how the system reacts. The actual random opcodes are what I need to see printed out directly from stress-ng before it actually executes the opcode. The kernel crash traces do not show those, just the aftermath. For instance, in the second trace I can see that the faulting instruction is c2070005 (lduw [ %i4 + %g5 ], %g1) and with i4: 00000000010e11c0 and g5: 794b00a7d5ede977, we can see how that instruction generated an unaligned access. But that is not the instruction executed by stress-ng, it's an instruction in the kernel, operating on faulty data, and I can't tell from the trace where that strange g5 value came from. The actual user instruction that was executed may provide a good hint.


I instrumented stress-ng with simple opcode block logging patch https://pastebin.com/1dZiCzCg and the results are hard to find usable, so far :(

1. The amount of code generated at each try is huge - last time it was more than the scrollback buffer of my "screen".

2. Adding these logging statements makes the bug harder to trigger - tried on 5.10 and it ran fine multiple times and then  failed but that took many minutes of running before the crash. I was observing the data over SSH, that might also change scheduling/CPU usage.

Any ideas for better logging that would not be in the way?

-- 
Meelis Roos <mroos@linux.ee>
