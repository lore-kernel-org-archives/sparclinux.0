From: Meelis Roos <mroos@linux.ee>
Date: Wed, 13 Aug 2014 11:44:42 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <alpine.SOC.1.00.1408131327250.18696@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1404170119550.20193@math.ut.ee> <20140729.162635.638786990787878495.davem@davemloft.net> <alpine.SOC.1.00.1407310101550.2065@math.ut.ee> <20140730.150722.861254999466992321.davem@davemloft.net>
In-Reply-To: <20140730.150722.861254999466992321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com, cat.schulze@alice-dsl.net


I tested the merged sparc64 fixes in current git.

V100: with hugetlb, looping git clone still hangs the machine. RED 
state on reboot has changed - before it gave the trace on reboot and 
continued, now it contonues looping with the trace indefinitely, gcc 
4.6.4

Netra X1: works fine with HugeTLB (but no hugetlbfs) and looping git 
clone, gcc 4.6.4.

V440: fails to boot with 3.16 and gcc 4.9.1 (same message as before, in 
fault_in_user_windows+0xe0/0x100). Tried latest git with gcc 4.9.1 but 
it stops after before getting to the previous failure point:
[   77.871887] console [tty0] enabled
[   77.912630] bootconsole [earlyprom0] disabled

T2000: works fine with gcc 4.9.1 and hugetlb, 3.16. Hangs at boot at the 
same point.

U2: looping git clone fails with 3.16, no hugetlb(!!!), gcc 4.6.4;

E420R: works fine with gcc 4.6.4. 3.16, hugetlb, looping git clone; 
fails to boot with current git

E220R: works with gcc 4.6.4, no hugetlb, 3.16. Hangs on boot with 
current git + hugetlb.

Did not test current git more. Will test the patches on top of 3.16 
separately to see if/which one of these is the culprit.

-- 
Meelis Roos (mroos@linux.ee)
