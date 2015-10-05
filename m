From: Meelis Roos <mroos@linux.ee>
Date: Mon, 05 Oct 2015 07:20:29 +0000
Subject: Re: blk_mq_register_disk: kobject (00000000009f2dd8): tried to init an initialized object, something
Message-Id: <alpine.LRH.2.20.1510051013250.20763@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee> <alpine.LRH.2.20.1510032231300.12322@math.ut.ee> <CACVXFVPBL60U-m37R-r_P2=fFHM7cTGOLJ+5MB5Pgwh1Xudy0w@mail.gmail.com>
In-Reply-To: <CACVXFVPBL60U-m37R-r_P2=fFHM7cTGOLJ+5MB5Pgwh1Xudy0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

> On Sun, Oct 4, 2015 at 3:33 AM, Meelis Roos <mroos@linux.ee> wrote:
> >> This is 4.3.0-rc1 on Sun E220R (dual-CPU sparc64). Sometimes it boots,
> >> sometimes it fails to boot with looping errors and finally a watchdog
> >> timeout. This console log from a failure. Config is below.
> >
> > I noticed blk-mq related changes in todays git. Retested, loop_init
> > still causes the same blk-mq problem.
> 
> 
> > [  100.063323] blk_mq_sysfs_init: init hctx_kobj fffff800ad8b95f8 0
> > [  100.135151] blk_mq_sysfs_init: init ctx_kobj fffff800af80cdd8 0
> > [  100.205952] blk_mq_sysfs_init: init ctx_kobj 00000000009f2dd8 1
> > [  100.276785] kobject (00000000009f2dd8): tried to init an initialized object, something is seriously wrong.
> 
> >From the debug log, the issue happened on ctx_kobj which is one
> percpu variable, and looks it can't be initialized by blk-mq more than
> one time.
> 
> I suspect it may be one memory issue, especiall in percpu allocation.
> The percpu variable's address for the offline CPU1 is a bit special, not
> like the other two online CPUs. And it might be helpful to enalbe
> 'Per cpu operations test' in' Kernel hacking  --->'/'Runtime Testing'
> of Kconfig to see if it can pass the test.

Configure the precpu test module to be compiled, included it in 
/proc/modules before loop. Percpu test test fine - 4 successful boots 
and one failure, and the test finds nothing bad:

[  137.674383] percpu test start
[  137.709010] percpu test done
[  137.876170] kobject (00000000009fcdd8): tried to init an initialized object, something is seriously wrong.
[  137.990966] CPU: 2 PID: 1172 Comm: modprobe Tainted: G    B DA C   LK 4.3.0-rc3-00199-g978ab6a #69


-- 
Meelis Roos (mroos@linux.ee)
