From: Christian Guggenberger
Date: Mon, 02 Feb 2004 14:09:31 +0000
Subject: Re: Oops with 2.6.2-rc3
Message-Id: <20040202150931.A714@pc9391.uni-regensburg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1075667365.2732.4.camel@bonnie79>
In-Reply-To: <1075667365.2732.4.camel@bonnie79>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 02.02.2004   14:32 Ben Collins wrote:
> > >>TPC; 0044f334 <__wake_up_common+14/80>   <==> >
> > >>g2; 004671e0 <wait_for_helper+0/a0>
> > >>o3; 0061bed8 <small_digits.0+0/28>
> > >>ret_pc; 004674f8 <queue_work+f8/120>
> > >>i7; 0044f520 <complete+40/a0>
> 
> My best guess is that this is occuring from call_usermodehelper() or
> request_module() (the only place that wait_for_helper() is referenced is
> in kernel/kmod.c).
> 
> What's the last lines printed before you get this oops? You can try
> disabling kmod to see if that fixes it, but I'd rather find out why it's
> occuring.
> 
> 
well, there are no suspicious lines printed before the oops.
Sometimes I see 'request_module: runaway loop modprobe net-pf-10', but these 
are printed out hours later than the oops.
So, for now I have net-pf-10 aliased to off in modprobe.conf. To your info, 
right before booting 2.6.2-rc3 for the first time I upgraded module-init-tools 
from pre5 to pre9, cause I have been annoyed by these 'request_module: failed 
/sbin/modprobe -- net-pf-10. error = 256' messages.

IMHO this oops is somehow correlated to SMP, because for now it's running fine 
since 4 hours in UP mode.
(normally in SMP mode the oops occured within an hour of uptime - no special 
load, no one logged in, no X)

I'll let this machine run in UP mode for the next 5 hours and will then do 
tests in SMP with kmod off.
This is a SBUS 2way UltrasparcI.



  - Christian

