From: Jan Engelhardt <jengelh@medozas.de>
Date: Thu, 03 Dec 2009 19:53:35 +0000
Subject: Re: No MC sched domains
Message-Id: <alpine.LSU.2.01.0912032046450.17046@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Wednesday 2009-12-02 23:57, David Miller wrote:

>From: Jan Engelhardt <jengelh@medozas.de>
>Date: Wed, 2 Dec 2009 19:41:34 +0100 (CET)
>
>> the T1 is said to be multi-core, however, I am not seeing any MC sched 
>> levels in dmesg as I do on x86. Why is that?
>
>The T1 cores are repesented as SMT units.
>
>On multi-chip T2 systems such as 5140 et al., we use MC to repesent
>the physical CPU chips.

Well I wonder, because htop gives me only something like the following
on `nice -n20 make -j24` in a Linux kernel build, and it surprises
me that it does not use all threads. I can generated some userspace
compiling load that distributes equally over all 24 threads, though.
Could it be something with the scheduler, or this very fact that
they are represented as SIBLING rather than MC?


  1  [||||||||||||||||||||||||100.0%]     Tasks: 208 total, 24 running
  2  [||||||||||||||||||||||||100.0%]     Load average: 14.38 4.84 2.29
  3  [||||||||||||||||||||||||100.0%]     Uptime: 00:27:11
  4  [||||||||||||||||||||||||100.0%]
  5  [|||||||||||||||||||||||||94.9%]
  6  [|||||||||||||||||||||||||95.3%]
  7  [|||||||||||||||||||||||||98.2%]
  8  [|||||||||||||||||||||||||93.8%]
  9  [                          0.0%]
  10 [                          nan%]
  11 [                          nan%]
  12 [                          nan%]
  13 [|||||||||||||||||||||||||93.4%]
  14 [|||||||||||||||||||||||||81.4%]
  15 [|||||||||||||||||||||||||86.9%]
  16 [|||||||||||||||||||||||  72.3%]
  17 [|||||||||||||||||||||||||99.1%]
  18 [||||||||||||||||||       58.8%]
  19 [                          nan%]
  20 [                          nan%]
  21 [||||||||||||||||||||||||100.0%]
  22 [||||||||||||||||||||||||100.0%]
  23 [||||||||||||||||||||||||100.0%]
  24 [||||||||||||||||||||||||100.0%]

(Standard top(1) also reflects this:)
Cpu8  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu9  :  0.0%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu10 :  0.0%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu11 :  0.0%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st

thanks,
Jan
