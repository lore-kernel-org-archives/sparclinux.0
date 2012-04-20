From: Konrad Eisele <konrad@gaisler.com>
Date: Fri, 20 Apr 2012 08:21:51 +0000
Subject: Re: sparc - generic clock event support
Message-Id: <4F911C9F.9070402@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404200704.GA16958@merkur.ravnborg.org>
In-Reply-To: <20120404200704.GA16958@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I runtime tested your patch. For single-CPU the patch works
> fine. For SMP I cannot test because Leon-SMP for 3.x doesnt
> work right now, also without your patch. The last version
> that I could verify LEON-SMP was 2.6.36, 3.0 should also work,
> however there your patches dont apply. I'll have to make
> Leon-SMP work with 3.4 first , then I can test the SMP part
> of the patch. However I'll write this on my todo list for
> after easter. As for Leon-SMP is broken right now I would
> vote for that your patches are applied now and after that to
> try to fix Leon-SMP.
> -- Konrad

With SMP working again I tested your timer patch for sparc-leon
SMP. It works!
-- Konrad

# cat /proc/cpuinfo
cpu             : LEON
fpu             : GRFPU
promlib         : Version 0 Revision 0
prom            : 0.0
type            : leon
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 70.04
Cpu1Bogo        : 70.86
MMU type        : LEON
contexts        : 256
nocache total   : 5242880
nocache used    : 118528
State:
CPU0            : online
CPU1            : online
# cat /proc/timer_list
Timer List Version: v0.6
HRTIMER_MAX_CLOCK_BASES: 3
now at 22403528241 nsecs

cpu: 0
  clock 0:
   .base:       f13d34e8
   .index:      0
   .resolution: 10000000 nsecs
   .get_time:   ktime_get
active timers:
  clock 1:
   .base:       f13d3520
   .index:      1
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 2:
   .base:       f13d3558
   .index:      2
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_boottime
active timers:

cpu: 1
  clock 0:
   .base:       f13db4e8
   .index:      0
   .resolution: 10000000 nsecs
   .get_time:   ktime_get
active timers:
  clock 1:
   .base:       f13db520
   .index:      1
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 2:
   .base:       f13db558
   .index:      2
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_boottime
active timers:


Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: percpu_ce
  max_delta_ns:   1000000068
  min_delta_ns:   100000
  mult:           4294967
  shift:          32
  mode:           2
  next_event:     2147483646999999999 nsecs
  set_next_event: percpu_ce_set_next_event
  set_mode:       percpu_ce_setup
  event_handler:  tick_handle_periodic
  retries:        0

Tick Device: mode:     0
Per CPU device: 1
Clock Event Device: percpu_ce
  max_delta_ns:   1000000068
  min_delta_ns:   100000
  mult:           4294967
  shift:          32
  mode:           2
  next_event:     2147483646999999999 nsecs
  set_next_event: percpu_ce_set_next_event
  set_mode:       percpu_ce_setup
  event_handler:  tick_handle_periodic
  retries:        0

#
