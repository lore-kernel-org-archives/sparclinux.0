From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 04 Nov 2007 19:55:20 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <472E23A8.90203@bzed.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080704000208020901040702"
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704000208020901040702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


> Ok, the key in the trace is:
> 
> Nov  2 16:25:30 titan kernel: [  978.134874]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
> Nov  2 16:25:30 titan kernel: [  978.257809]              TPC[_write_unlock_irq+0x20/0x110]
>  ...
> Nov  2 16:25:30 titan kernel: [  978.507778]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
> Nov  2 16:25:30 titan kernel: [  978.630707]              TPC[cheetah_xcall_deliver+0x174/0x23c]
> 
> The first symbol is misleading, it says _write_unlock_irq but actually
> in the assembler the PC is in the spinlock read spinning loop
> section.  So actually it's hanging in _spin_lock().
> 
> CPU #3 is trying to send a cross-call message interrupt, but for
> some reason that isn't making forward progress.
> 
> Let's see what's calling these things by adding some more debugging
> information.  Please retry the test with the following patch on
> top of the original sysrq-g debugging patch and please get new
> logs when it hangs.


Today I was a bit out of luck, either the machine crashed so badly that
it just didn't react on anything anymore, or it didn't crash.
The machine went amok a bit slower when I did the following things,
which also resulted in the attached sysrq output.
- run stress -c 2 to get the load up, didn't need that the last time...
- run something like `while true; do echo g > /proc/sysrg-trigger; sleep
0.5; done`
- run aptitude -u several times until the machine died.

So I'm not sure if the result is really useful for you - if not just let
me know. I've attached the last ~10-20 sysrq-g outputs - as it was
running in a loop I have a ton of them. In case you're wondering: http
is aptitude's http method.

We'll also run the patched Kernel on a US II machine form tomorrow on -
but it always took a longer time until it crashed, so we'll see if it
happens at all.

Thanks for your work,


Bernd


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>

--------------080704000208020901040702
Content-Type: application/pgp-keys;
 name="sysrq2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq2.txt"

Nov  4 19:11:15 titan kernel: [ 1811.999438] SysRq : Show Global CPU Regs
Nov  4 19:11:15 titan kernel: [ 1812.045420]   CPU[  0]: TSTATE[0000004482001a04] TPC[00000000f7f00524] TNPC[00000000f7f00528] TASK[stress:3380]
Nov  4 19:11:15 titan kernel: [ 1812.045447]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:15 titan kernel: [ 1812.045552]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:15 titan kernel: [ 1812.045564]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:15 titan kernel: [ 1812.045576]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:15 titan kernel: [ 1812.045588]   CPU[  2]: TSTATE[0000000011009606] TPC[000000000045c280] TNPC[000000000045c284] TASK[stress:3379]
Nov  4 19:11:15 titan kernel: [ 1812.045605]              TPC[put_prev_task_fair+0x64/0x70]
Nov  4 19:11:15 titan kernel: [ 1812.045617]              O7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:15 titan kernel: [ 1812.045789]              I7[schedule+0x3d0/0x7a4]
Nov  4 19:11:15 titan kernel: [ 1812.045800] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:15 titan kernel: [ 1812.207479] SysRq : Show Global CPU Regs
Nov  4 19:11:15 titan kernel: [ 1812.253434]   CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[00000000f7f004cc] TASK[NULL:-1]
Nov  4 19:11:15 titan kernel: [ 1812.253462]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a80] TNPC[0000000000441a84] TASK[http:3267]
Nov  4 19:11:15 titan kernel: [ 1812.253568]              TPC[cheetah_xcall_deliver+0x17c/0x23c]
Nov  4 19:11:15 titan kernel: [ 1812.253580]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:15 titan kernel: [ 1812.253594]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:15 titan kernel: [ 1812.253606]   CPU[  2]: TSTATE[0000000011009607] TPC[0000000000457918] TNPC[000000000045791c] TASK[stress:3379]
Nov  4 19:11:15 titan kernel: [ 1812.253732]              TPC[update_curr+0x68/0x114]
Nov  4 19:11:15 titan kernel: [ 1812.253755]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:15 titan kernel: [ 1812.253767]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:15 titan kernel: [ 1812.253777] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:15 titan kernel: [ 1812.415533] SysRq : Show Global CPU Regs
Nov  4 19:11:15 titan kernel: [ 1812.461453]   CPU[  0]: TSTATE[0000004482001a03] TPC[0000000000013afc] TNPC[0000000000013b00] TASK[stress:3380]
Nov  4 19:11:15 titan kernel: [ 1812.461480]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:15 titan kernel: [ 1812.461583]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:15 titan kernel: [ 1812.461595]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:15 titan kernel: [ 1812.461606]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:15 titan kernel: [ 1812.461619]   CPU[  2]: TSTATE[0000004411009600] TPC[00000000004578e4] TNPC[00000000004578e8] TASK[stress:3379]
Nov  4 19:11:15 titan kernel: [ 1812.461635]              TPC[update_curr+0x34/0x114]
Nov  4 19:11:15 titan kernel: [ 1812.461649]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:15 titan kernel: [ 1812.461809]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:15 titan kernel: [ 1812.461820] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:15 titan kernel: [ 1812.623719] SysRq : Show Global CPU Regs
Nov  4 19:11:15 titan kernel: [ 1812.669667]   CPU[  0]: TSTATE[0000001182001a04] TPC[00000000f7f004e0] TNPC[00000000f7f004e4] TASK[stress:3380]
Nov  4 19:11:15 titan kernel: [ 1812.669695]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:15 titan kernel: [ 1812.669800]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:15 titan kernel: [ 1812.669811]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:15 titan kernel: [ 1812.669823]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:15 titan kernel: [ 1812.669835]   CPU[  2]: TSTATE[0000009111009601] TPC[0000000000457458] TNPC[000000000045745c] TASK[stress:3379]
Nov  4 19:11:15 titan kernel: [ 1812.669852]              TPC[calc_delta_mine+0x8/0x84]
Nov  4 19:11:15 titan kernel: [ 1812.669872]              O7[hrtimer_run_queues+0x10c/0x1cc]
Nov  4 19:11:15 titan kernel: [ 1812.670029]              I7[update_curr+0x98/0x114]
Nov  4 19:11:15 titan kernel: [ 1812.670039] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:16 titan kernel: [ 1812.831767] SysRq : Show Global CPU Regs
Nov  4 19:11:16 titan kernel: [ 1812.877702]   CPU[  0]: TSTATE[0000000082001a04] TPC[00000000f7dd43a0] TNPC[00000000f7dd43a4] TASK[stress:3380]
Nov  4 19:11:16 titan kernel: [ 1812.877730]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:16 titan kernel: [ 1812.877837]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:16 titan kernel: [ 1812.877849]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:16 titan kernel: [ 1812.877863]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:16 titan kernel: [ 1812.877875]   CPU[  2]: TSTATE[0000004411009607] TPC[00000000004578e4] TNPC[00000000004578e8] TASK[stress:3379]
Nov  4 19:11:16 titan kernel: [ 1812.877999]              TPC[update_curr+0x34/0x114]
Nov  4 19:11:16 titan kernel: [ 1812.878022]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:16 titan kernel: [ 1812.878034]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:16 titan kernel: [ 1812.878044] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:16 titan kernel: [ 1813.039847] SysRq : Show Global CPU Regs
Nov  4 19:11:16 titan kernel: [ 1813.085807]   CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
Nov  4 19:11:16 titan kernel: [ 1813.085836]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:16 titan kernel: [ 1813.085859]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:16 titan kernel: [ 1813.085959]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:16 titan kernel: [ 1813.085971]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:16 titan kernel: [ 1813.085983]   CPU[  2]: TSTATE[0000009911009606] TPC[000000000045c250] TNPC[000000000045c254] TASK[stress:3379]
Nov  4 19:11:16 titan kernel: [ 1813.085997]              TPC[put_prev_task_fair+0x34/0x70]
Nov  4 19:11:16 titan kernel: [ 1813.086010]              O7[__update_rq_clock+0x4/0x88]
Nov  4 19:11:16 titan kernel: [ 1813.086027]              I7[schedule+0x3d0/0x7a4]
Nov  4 19:11:16 titan kernel: [ 1813.086037] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:16 titan kernel: [ 1813.247961] SysRq : Show Global CPU Regs
Nov  4 19:11:16 titan kernel: [ 1813.293929]   CPU[  0]: TSTATE[0000004482001a04] TPC[00000000f7f004c0] TNPC[00000000f7f004c4] TASK[stress:3380]
Nov  4 19:11:16 titan kernel: [ 1813.293957]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:16 titan kernel: [ 1813.294061]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:16 titan kernel: [ 1813.294073]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:16 titan kernel: [ 1813.294084]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:16 titan kernel: [ 1813.294096]   CPU[  2]: TSTATE[0000000011009601] TPC[0000000000457450] TNPC[0000000000457454] TASK[stress:3379]
Nov  4 19:11:16 titan kernel: [ 1813.294114]              TPC[calc_delta_mine+0x0/0x84]
Nov  4 19:11:16 titan kernel: [ 1813.294127]              O7[update_curr+0x84/0x114]
Nov  4 19:11:16 titan kernel: [ 1813.294291]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:16 titan kernel: [ 1813.294302] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:16 titan kernel: [ 1813.455981] SysRq : Show Global CPU Regs
Nov  4 19:11:16 titan kernel: [ 1813.501966]   CPU[  0]: TSTATE[0000000082001a05] TPC[00000000f7dd4734] TNPC[00000000f7dd4738] TASK[stress:3380]
Nov  4 19:11:16 titan kernel: [ 1813.501993]   CPU[  1]: TSTATE[0000000011009606] TPC[000000000042faa0] TNPC[000000000042fc18] TASK[http:3267]
Nov  4 19:11:16 titan kernel: [ 1813.502110]              TPC[stick_get_tick+0x10/0x14]
Nov  4 19:11:16 titan kernel: [ 1813.502123]              O7[__delay+0x28/0x48]
Nov  4 19:11:16 titan kernel: [ 1813.502138]              I7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov  4 19:11:16 titan kernel: [ 1813.502150]   CPU[  2]: TSTATE[0000009111009601] TPC[0000000000457458] TNPC[000000000045745c] TASK[stress:3379]
Nov  4 19:11:16 titan kernel: [ 1813.502281]              TPC[calc_delta_mine+0x8/0x84]
Nov  4 19:11:16 titan kernel: [ 1813.502294]              O7[run_timer_softirq+0xc/0x1e8]
Nov  4 19:11:16 titan kernel: [ 1813.502307]              I7[update_curr+0x98/0x114]
Nov  4 19:11:16 titan kernel: [ 1813.502317] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:16 titan kernel: [ 1813.664111] SysRq : Show Global CPU Regs
Nov  4 19:11:16 titan kernel: [ 1813.710086]   CPU[  0]: TSTATE[0000001182001a04] TPC[00000000f7f004e0] TNPC[00000000f7f004e4] TASK[stress:3380]
Nov  4 19:11:16 titan kernel: [ 1813.710114]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:16 titan kernel: [ 1813.710201]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:16 titan kernel: [ 1813.710214]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:16 titan kernel: [ 1813.710226]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:16 titan kernel: [ 1813.710238]   CPU[  2]: TSTATE[0000004411009607] TPC[00000000004578e4] TNPC[00000000004578e8] TASK[stress:3379]
Nov  4 19:11:16 titan kernel: [ 1813.710256]              TPC[update_curr+0x34/0x114]
Nov  4 19:11:16 titan kernel: [ 1813.710269]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:16 titan kernel: [ 1813.710435]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:16 titan kernel: [ 1813.710446] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:17 titan kernel: [ 1813.872253] SysRq : Show Global CPU Regs
Nov  4 19:11:17 titan kernel: [ 1813.918212]   CPU[  0]: TSTATE[0000004482001a03] TPC[0000000000026740] TNPC[00000000f7f004ac] TASK[stress:3380]
Nov  4 19:11:17 titan kernel: [ 1813.918240]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:17 titan kernel: [ 1813.918350]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:17 titan kernel: [ 1813.918362]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:17 titan kernel: [ 1813.918375]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:17 titan kernel: [ 1813.918387]   CPU[  2]: TSTATE[0000004411009601] TPC[00000000004578e4] TNPC[00000000004578e8] TASK[stress:3379]
Nov  4 19:11:17 titan kernel: [ 1813.918513]              TPC[update_curr+0x34/0x114]
Nov  4 19:11:17 titan kernel: [ 1813.918536]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:17 titan kernel: [ 1813.918548]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:17 titan kernel: [ 1813.918559] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:17 titan kernel: [ 1814.080326] SysRq : Show Global CPU Regs
Nov  4 19:11:17 titan kernel: [ 1814.126231]   CPU[  0]: TSTATE[0000004482001a04] TPC[00000000f7f00524] TNPC[00000000f7f00528] TASK[stress:3380]
Nov  4 19:11:17 titan kernel: [ 1814.126259]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:17 titan kernel: [ 1814.126365]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:17 titan kernel: [ 1814.126377]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:17 titan kernel: [ 1814.126390]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:17 titan kernel: [ 1814.126402]   CPU[  2]: TSTATE[0000004411009600] TPC[00000000004578e4] TNPC[00000000004578e8] TASK[stress:3379]
Nov  4 19:11:17 titan kernel: [ 1814.126419]              TPC[update_curr+0x34/0x114]
Nov  4 19:11:17 titan kernel: [ 1814.126441]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:17 titan kernel: [ 1814.126575]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:17 titan kernel: [ 1814.126586] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:17 titan kernel: [ 1814.288423] SysRq : Show Global CPU Regs
Nov  4 19:11:17 titan kernel: [ 1814.334354]   CPU[  0]: TSTATE[0000004482001a04] TPC[00000000f7f004b0] TNPC[00000000f7f004b4] TASK[stress:3380]
Nov  4 19:11:17 titan kernel: [ 1814.334382]   CPU[  1]: TSTATE[0000000011009606] TPC[000000000042fbfc] TNPC[000000000042fa90] TASK[http:3267]
Nov  4 19:11:17 titan kernel: [ 1814.334498]              TPC[__delay+0x14/0x48]
Nov  4 19:11:17 titan kernel: [ 1814.334509]              O7[__delay+0x10/0x48]
Nov  4 19:11:17 titan kernel: [ 1814.334523]              I7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov  4 19:11:17 titan kernel: [ 1814.334535]   CPU[  2]: TSTATE[0000004411009607] TPC[00000000004578e4] TNPC[00000000004578e8] TASK[stress:3379]
Nov  4 19:11:17 titan kernel: [ 1814.334554]              TPC[update_curr+0x34/0x114]
Nov  4 19:11:17 titan kernel: [ 1814.334677]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:17 titan kernel: [ 1814.334689]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:17 titan kernel: [ 1814.334700] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:17 titan kernel: [ 1814.496504] SysRq : Show Global CPU Regs
Nov  4 19:11:17 titan kernel: [ 1814.542474]   CPU[  0]: TSTATE[0000000082001a05] TPC[00000000f7dd4744] TNPC[00000000f7dd4748] TASK[stress:3380]
Nov  4 19:11:17 titan kernel: [ 1814.542500]   CPU[  1]: TSTATE[0000000011009606] TPC[000000000042fbfc] TNPC[000000000042fa90] TASK[http:3267]
Nov  4 19:11:17 titan kernel: [ 1814.542616]              TPC[__delay+0x14/0x48]
Nov  4 19:11:17 titan kernel: [ 1814.542630]              O7[__delay+0x10/0x48]
Nov  4 19:11:17 titan kernel: [ 1814.542643]              I7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov  4 19:11:17 titan kernel: [ 1814.542655]   CPU[  2]: TSTATE[0000004411009600] TPC[00000000004578e4] TNPC[00000000004578e8] TASK[stress:3379]
Nov  4 19:11:17 titan kernel: [ 1814.542674]              TPC[update_curr+0x34/0x114]
Nov  4 19:11:17 titan kernel: [ 1814.542794]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:17 titan kernel: [ 1814.542806]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:17 titan kernel: [ 1814.542817] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:18 titan kernel: [ 1814.704653] SysRq : Show Global CPU Regs
Nov  4 19:11:18 titan kernel: [ 1814.750598]   CPU[  0]: TSTATE[0000004482001a03] TPC[0000000000026788] TNPC[000000000002678c] TASK[stress:3380]
Nov  4 19:11:18 titan kernel: [ 1814.750626]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:18 titan kernel: [ 1814.750732]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:18 titan kernel: [ 1814.750744]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:18 titan kernel: [ 1814.750757]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:18 titan kernel: [ 1814.750769]   CPU[  2]: TSTATE[0000000011009601] TPC[0000000000457918] TNPC[000000000045791c] TASK[stress:3379]
Nov  4 19:11:18 titan kernel: [ 1814.750789]              TPC[update_curr+0x68/0x114]
Nov  4 19:11:18 titan kernel: [ 1814.750945]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:18 titan kernel: [ 1814.750957]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:18 titan kernel: [ 1814.750968] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:18 titan kernel: [ 1814.912669] SysRq : Show Global CPU Regs
Nov  4 19:11:18 titan kernel: [ 1814.958618]   CPU[  0]: TSTATE[0000004482001a04] TPC[00000000f7f004d8] TNPC[00000000f7f004dc] TASK[stress:3380]
Nov  4 19:11:18 titan kernel: [ 1814.958644]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:18 titan kernel: [ 1814.958751]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:18 titan kernel: [ 1814.958763]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:18 titan kernel: [ 1814.958776]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:18 titan kernel: [ 1814.958788]   CPU[  2]: TSTATE[0000004411009600] TPC[00000000004578e4] TNPC[00000000004578e8] TASK[stress:3379]
Nov  4 19:11:18 titan kernel: [ 1814.958806]              TPC[update_curr+0x34/0x114]
Nov  4 19:11:18 titan kernel: [ 1814.958933]              O7[sched_clock+0x10/0x30]
Nov  4 19:11:18 titan kernel: [ 1814.958945]              I7[put_prev_task_fair+0x48/0x70]
Nov  4 19:11:18 titan kernel: [ 1814.958956] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:18 titan kernel: [ 1815.120902] SysRq : Show Global CPU Regs
Nov  4 19:11:18 titan kernel: [ 1815.166837]   CPU[  0]: TSTATE[0000000000000000] TPC[00000000f7f004f0] TNPC[00000000f7f042c0] TASK[stress:3380]
Nov  4 19:11:18 titan kernel: [ 1815.166864]   CPU[  1]: TSTATE[0000000011009606] TPC[000000000042fc14] TNPC[000000000042fa90] TASK[http:3267]
Nov  4 19:11:18 titan kernel: [ 1815.166979]              TPC[__delay+0x2c/0x48]
Nov  4 19:11:18 titan kernel: [ 1815.166990]              O7[__delay+0x28/0x48]
Nov  4 19:11:18 titan kernel: [ 1815.167003]              I7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov  4 19:11:18 titan kernel: [ 1815.167015]   CPU[  2]: TSTATE[0000009911009607] TPC[000000000045c250] TNPC[000000000045c254] TASK[stress:3379]
Nov  4 19:11:18 titan kernel: [ 1815.167032]              TPC[put_prev_task_fair+0x34/0x70]
Nov  4 19:11:18 titan kernel: [ 1815.167118]              O7[__update_rq_clock+0x4/0x88]
Nov  4 19:11:18 titan kernel: [ 1815.167201]              I7[schedule+0x3d0/0x7a4]
Nov  4 19:11:18 titan kernel: [ 1815.167212] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:18 titan kernel: [ 1815.328708] SysRq : Show Global CPU Regs
Nov  4 19:11:18 titan kernel: [ 1815.374636]   CPU[  0]: TSTATE[0000001182001a04] TPC[00000000f7f004e0] TNPC[00000000f7f004e4] TASK[stress:3380]
Nov  4 19:11:18 titan kernel: [ 1815.374662]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:18 titan kernel: [ 1815.374763]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:18 titan kernel: [ 1815.374775]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:18 titan kernel: [ 1815.374788]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:18 titan kernel: [ 1815.374799]   CPU[  2]: TSTATE[0000009911009607] TPC[000000000045c250] TNPC[000000000045c254] TASK[stress:3379]
Nov  4 19:11:18 titan kernel: [ 1815.374814]              TPC[put_prev_task_fair+0x34/0x70]
Nov  4 19:11:18 titan kernel: [ 1815.374896]              O7[__update_rq_clock+0x4/0x88]
Nov  4 19:11:18 titan kernel: [ 1815.374996]              I7[schedule+0x3d0/0x7a4]
Nov  4 19:11:18 titan kernel: [ 1815.375007] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:18 titan kernel: [ 1815.536928] SysRq : Show Global CPU Regs
Nov  4 19:11:18 titan kernel: [ 1815.582860]   CPU[  0]: TSTATE[0000000000000000] TPC[0000000000013ae4] TNPC[0000000000013ae8] TASK[NULL:-1]
Nov  4 19:11:18 titan kernel: [ 1815.582886]   CPU[  1]: TSTATE[0000000011009606] TPC[000000000042fbfc] TNPC[000000000042fa90] TASK[http:3267]
Nov  4 19:11:18 titan kernel: [ 1815.582987]              TPC[__delay+0x14/0x48]
Nov  4 19:11:18 titan kernel: [ 1815.582998]              O7[__delay+0x10/0x48]
Nov  4 19:11:18 titan kernel: [ 1815.583009]              I7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov  4 19:11:18 titan kernel: [ 1815.583021]   CPU[  2]: TSTATE[0000009911009600] TPC[000000000045c240] TNPC[000000000045c244] TASK[stress:3379]
Nov  4 19:11:18 titan kernel: [ 1815.583035]              TPC[put_prev_task_fair+0x24/0x70]
Nov  4 19:11:18 titan kernel: [ 1815.583048]              O7[__update_rq_clock+0x4/0x88]
Nov  4 19:11:18 titan kernel: [ 1815.583059]              I7[schedule+0x3d0/0x7a4]
Nov  4 19:11:18 titan kernel: [ 1815.583237] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:19 titan kernel: [ 1815.761387] SysRq : Show Global CPU Regs
Nov  4 19:11:19 titan kernel: [ 1815.807338]   CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
Nov  4 19:11:19 titan kernel: [ 1815.807366]   CPU[  1]: TSTATE[0000004411009605] TPC[0000000000441ad0] TNPC[0000000000441b1c] TASK[http:3267]
Nov  4 19:11:19 titan kernel: [ 1815.807468]              TPC[cheetah_xcall_deliver+0x1cc/0x23c]
Nov  4 19:11:19 titan kernel: [ 1815.807480]              O7[cheetah_xcall_deliver+0x1c0/0x23c]
Nov  4 19:11:19 titan kernel: [ 1815.807492]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:19 titan kernel: [ 1815.807504]   CPU[  2]: TSTATE[0000009911009600] TPC[000000000045c250] TNPC[000000000045c254] TASK[stress:3379]
Nov  4 19:11:19 titan kernel: [ 1815.807520]              TPC[put_prev_task_fair+0x34/0x70]
Nov  4 19:11:19 titan kernel: [ 1815.807534]              O7[__update_rq_clock+0x4/0x88]
Nov  4 19:11:19 titan kernel: [ 1815.807702]              I7[schedule+0x3d0/0x7a4]
Nov  4 19:11:19 titan kernel: [ 1815.807712] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:19 titan kernel: [ 1815.969187] SysRq : Show Global CPU Regs
Nov  4 19:11:19 titan kernel: [ 1816.015149]   CPU[  0]: TSTATE[0000004482001a04] TPC[00000000f7f004d8] TNPC[00000000f7f004dc] TASK[stress:3380]
Nov  4 19:11:19 titan kernel: [ 1816.015177]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:19 titan kernel: [ 1816.015279]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:19 titan kernel: [ 1816.015291]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:19 titan kernel: [ 1816.015303]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:19 titan kernel: [ 1816.015315]   CPU[  2]: TSTATE[0000009911009607] TPC[000000000045c250] TNPC[000000000045c254] TASK[stress:3379]
Nov  4 19:11:19 titan kernel: [ 1816.015329]              TPC[put_prev_task_fair+0x34/0x70]
Nov  4 19:11:19 titan kernel: [ 1816.015342]              O7[__update_rq_clock+0x4/0x88]
Nov  4 19:11:19 titan kernel: [ 1816.015512]              I7[schedule+0x3d0/0x7a4]
Nov  4 19:11:19 titan kernel: [ 1816.015522] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]
Nov  4 19:11:19 titan kernel: [ 1816.177206] SysRq : Show Global CPU Regs
Nov  4 19:11:19 titan kernel: [ 1816.223166]   CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
Nov  4 19:11:19 titan kernel: [ 1816.223193]   CPU[  1]: TSTATE[0000000011009605] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[http:3267]
Nov  4 19:11:19 titan kernel: [ 1816.223292]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  4 19:11:19 titan kernel: [ 1816.223305]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  4 19:11:19 titan kernel: [ 1816.223316]              I7[flush_dcache_page_all+0x178/0x240]
Nov  4 19:11:19 titan kernel: [ 1816.223328]   CPU[  2]: TSTATE[0000009911009606] TPC[000000000045c250] TNPC[000000000045c254] TASK[stress:3379]
Nov  4 19:11:19 titan kernel: [ 1816.223343]              TPC[put_prev_task_fair+0x34/0x70]
Nov  4 19:11:19 titan kernel: [ 1816.223355]              O7[__update_rq_clock+0x4/0x88]
Nov  4 19:11:19 titan kernel: [ 1816.223525]              I7[schedule+0x3d0/0x7a4]
Nov  4 19:11:19 titan kernel: [ 1816.223536] * CPU[  3]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3110]

--------------080704000208020901040702--
