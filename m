From: Pierre Muller <pierre@freepascal.org>
Date: Wed, 02 Aug 2017 09:04:20 +0000
Subject: Sparc64 kernel rcu_sched stalls (was: Reproducer for sparc64 kernel lock-up bug)
Message-Id: <80e15663-e062-3de8-9597-efdebd688791@freepascal.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org



Le 27/07/2017 à 01:41, David Miller a écrit :
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date: Fri, 21 Jul 2017 16:28:01 +0200
> 
>> When running the attached, statically linked binary on a recent
>> kernel, the kernel locks up with:
> 
> Thanks a lot, as soon as I sort through the RCU stall bug I'll take
> a close look at this!
> 


Hi David,

  is this responsible for the fact that sometimes
my bash sleep commands do not return after the argument given time is elapsed?

  Is there a way to 'shake' the system?

  I do have a lot of
INFO: rcu_sched detected stalls on CPUs/tasks
messages in dmesg output, but I do not see
directly any user program that is causing the problem
in the output.

There are however a lot of segfault reports that are generated
by the Free Pascal sparc64 testuite runs, on Debian stadler machine.

Are the two related?

Could this be useful for you to debug the problem?

Pierre Muller
