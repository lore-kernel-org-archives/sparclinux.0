From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2014 05:09:25 +0000
Subject: Re: [PATCH 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <20140821.220925.2120165492230276147.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 21 Aug 2014 14:14:50 +0200

> Maybe the second opcode is ignored because it is a conditional jump
> or maybe they are always equal.  But whatever it is confusing.

I totally agree that the patch should use a nop in the delay slot so
that it's clear and easier to understand, however I wanted to show how
the behavior is well defined and can even be used intentionally for
useful purposes. :-)

Branches in a delay slot a long time ago were marked as undefined
behavior, but for some time now they are expected to behave in
a certain way, consider:

	ba	label_a
	ba	label_b

this is a neat way to execute one instruction at label_a then go
to label_b.

More generically:

	jmpl	%reg
	ba	interpreter_continue
interpreter_continue:

which you could use to build an instruction at a time execution
engine, which only must elide emulate instructions which use registers
in this special code sequence.

Gordan Irlam used such a technique for his sun4d tracer named SKY.
Unfortunately the SKY web page no longer exists, but this tracer led
to discoveries that brough about things such as the SLAB allocator.

Anyways, all delayed control transfer instructions do is set NPC.  So:

0x00	ba	0x20
0x04	ba	0x30
 ...
0x20	nop
 ...
0x30	nop
 ...

At the first instruction, PC=0x00 and NPC=0x04

PC will be set to NPC at the end of execution.
For non-branches NPC is set to NPC + 0x4 but for this
delayed control transfer NPC will be set to 0x20 instead.

So PC=0x04 and NPC=0x20 when we get to the second instruction
in the first instruction's delay slot.

PC will be set to 0x20 and NPC will be set to 0x30

The nop at 0x20 will be executed, PC will be set to 0x30 and NPC
will be set to 0x34.

Finally we execute the nop at 0x30 and continue to linearly execute.

