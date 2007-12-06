From: Bernd Zeimetz <bernd@bzed.de>
Date: Thu, 06 Dec 2007 10:43:45 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <4757D261.4090907@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bernd Zeimetz <bernd@bzed.de>
> Date: Fri, 16 Nov 2007 22:17:07 +0100
> 
>> The sysrq-g output is attached, I hope you can make sense out of it.
>> We'll also add some extra workload to the other machines here to try to
>> trigger the bug on other CPUs, too.
> 
> I just got back from my vacation and started looking at these
> dumps.  I think there might be some bug in cheetah_xcall_deliver(),
> I'll try to diagnose this some more.

I'm not sure if it is related, but non-SMP Kernels don't boot at all on
the machine.

> If you cannot reproduce this bug on non-Ultra-III systems that
> would help confirm or deny my theory.  Have you been able to
> trigger this on your Ultra-II machine for example?  If so, what
> do the sysrq-g traces look like there?

Since your Futex bugfix the Ultra-II machine runs pretty stable. I did
not manage to trigger the bug there, but it was hard to trigger the bug
the first time there already - even if I run a Kernel without the Futex
bugfix the machine will just hang itself at some random point, I never
managed to reproduce the bug easily on US II.


Best regards,

Bernd

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
