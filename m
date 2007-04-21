From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sat, 21 Apr 2007 19:37:39 +0000
Subject: Re: Soft Lockup on sun4c
Message-Id: <Pine.LNX.4.61.0704212135060.9989@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Apr 21 2007 20:33, Mark Fortescue wrote:
>
> I will check that if I ever get far enough. The system locks up in
> kernel_exec of the initail process /sbin/bash.static
> (init=/sbin/bash.static).

Perhaps try sash if it is installed.

> Is there a setting to make L1-A enabled by default?

Not that I know of any boot-time option, but there is always the source code.
BTW, stop_a is enabled by default (which bugs me a bit since it is disabled
by default when aurora is up and running unless you set the sysctl somewhere.)

21:33 ichi:../sparc64/kernel > grep -r stop_a .
./setup.c:int stop_a_enabled = 1;
(same for sparc32)


Jan
-- 
