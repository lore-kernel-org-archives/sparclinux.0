From: christian@j-son.org
Date: Tue, 13 Jan 2004 20:06:41 +0000
Subject: Re: Status of Ross hyperSPARC on linux-2.4.x and linux-2.6.x?
Message-Id: <20040113210640.A4824@sparky.j-son.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040113204206.A988@sparky.j-son.org>
In-Reply-To: <20040113204206.A988@sparky.j-son.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 13, 2004 at 08:42:06PM +0100, christian@j-son.org wrote:
> Just a little ping for me (and anyone else).. what's the status of the
> linux kernels 2.4 and 2.6 for running Ross' hyperSPARC processors?
> 
> This is what I have (running up to date Aurora SPARC Linux 1.0)
> 
> cpu		: ROSS HyperSparc RT625 or RT626
> fpu		: ROSS HyperSparc combined IU/FPU
> promlib		: Version 3 Revision 2
> prom		: 2.25
> type		: sun4m
> ncpus probed	: 4
> ncpus active	: 4
> Cpu0Bogo	: 124.92
> Cpu1Bogo	: 125.33
> Cpu2Bogo	: 125.33
> Cpu3Bogo	: 125.33
> MMU type	: ROSS HyperSparc
> contexts	: 4096
> nocache total	: 5242880
> nocache used	: 159232
> CPU0		: online
> CPU1		: online
> CPU2		: online
> CPU3		: online

I get a lot of system cpu here and little user....

(null)  9:04pm  up 31 min,  2 users,  load average: 6.18, 5.81, 3.66
57 processes: 53 sleeping, 4 running, 0 zombie, 0 stopped
CPU0 states: 23.0% user, 76.1% system,  0.0% nice,  0.1% idle
CPU1 states: 34.1% user, 65.0% system,  0.0% nice,  0.1% idle
CPU2 states: 30.0% user, 69.1% system,  0.0% nice,  0.1% idle
CPU3 states: 13.1% user, 86.0% system,  0.0% nice,  0.1% idle
Mem:   444644K av,   98268K used,  346376K free,       0K shrd,    7860K buff
Swap:  917224K av,       0K used,  917224K free                   61848K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 5338 chj       17   0  1436 1436   832 R    73.7  0.3   0:02 as
 5330 chj       15   0  1156 1152   928 R    37.8  0.2   0:02 top
 1542 chj       11   0  1228 1228  1136 S    30.0  0.2   1:49 sh
 5351 chj       12   0   152  152   128 R    16.8  0.0   0:00 cat
 5350 chj        7   0  1028 1028   960 S    14.8  0.2   0:00 sh
 5306 chj        9   0  1028 1028   960 S     9.8  0.2   0:01 sh
 4869 chj        9   0  6636 6636  3220 S     5.7  1.4   0:37 emacs
   15 root       9   0     0    0     0 SW    3.2  0.0   0:17 kjournald
 1543 chj        7   0  1072 1072  1060 R     0.8  0.2   0:34 sh
    1 root       9   0   564  564   496 S     0.0  0.1   0:02 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:02 keventd
    3 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU1
    5 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU2

what's up?

/ChJ
