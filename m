From: David Miller <davem@davemloft.net>
Date: Sat, 17 Apr 2010 07:51:09 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100417.005109.32311008.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 16 Apr 2010 16:17:44 -0700 (PDT)

> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Sat, 17 Apr 2010 01:14:12 +0200
> 
>> Hmm, just a random idea: do you think it could be due to stack overflows?
>> Because the function graph eats more stack by digging to function graph
>> handlers, ring buffer, etc...
>> 
>> It diggs further than what is supposed to happen without tracing.
> 
> I have mcount checking for stack-overflow by hand in assembler
> during these tests, it even knows about the irq stacks.
> 
> And those checks are not triggering.

Ugh...  hold on.

They're not triggering because I put the test assembler into mcount
and dynamic ftrace patches the call sites to bypass mcount altogether
:-)

Doing real tests now, and I bet you're right.

That's pretty insane though, as we use 16K stacks on sparc64 and
the gcc I'm using has the minimum stack frame decreased down to
176 bytes (used to be 192).  I'd be interested to see what one
of these too-large backtraces look like.

Hmmm, will it be in the scheduler load balancing code? :-)

Will report once I have some goot triggers.
