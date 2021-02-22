From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 22 Feb 2021 17:48:57 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <d55f1011-375a-cd41-5c4e-3e38d97e3cba@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2/22/21 10:21 AM, Anatoly Pugachev wrote:
> On Mon, Feb 22, 2021 at 7:21 PM Rob Gardner <rob.gardner@oracle.com> wrote:
>> Can you have stress-ng print out the random opcodes as it runs? That
>> might give a hint about where things are going wrong.
> Rob,
>
> there's quite a few different ones on my tests, please see [1], [2]
>
> 1. https://www.spinics.net/lists/sparclinux/msg25915.html
> 2. https://www.spinics.net/lists/sparclinux/msg25917.html

I've looked at those and they don't contain the information I am 
interested in. I believe that stress-ng issues random opcodes in order 
to test how the system reacts. The actual random opcodes are what I need 
to see printed out directly from stress-ng before it actually executes 
the opcode. The kernel crash traces do not show those, just the 
aftermath. For instance, in the second trace I can see that the faulting 
instruction is c2070005 (lduw [ %i4 + %g5 ], %g1) and with i4: 
00000000010e11c0 and g5: 794b00a7d5ede977, we can see how that 
instruction generated an unaligned access. But that is not the 
instruction executed by stress-ng, it's an instruction in the kernel, 
operating on faulty data, and I can't tell from the trace where that 
strange g5 value came from. The actual user instruction that was 
executed may provide a good hint.

Rob
