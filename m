From: Jan Engelhardt <jengelh@inai.de>
Date: Thu, 27 Mar 2014 01:36:43 +0000
Subject: rcu_sched detects stalls on 3.13
Message-Id: <alpine.LSU.2.11.1403270219150.12214@nerf08.vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,


I am observing rcu stall warnings on 3.13.6.
The RCU timeout in /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
is set to 40 seconds. (That was probably me.) Still I wonder what takes
so much processing time that it takes longer than 40 seconds, on a system
that has "just" 24 CPUs. CONFIG_RCU_NOCB_CPU is not set.
If anything, how could I debug this?
.config needed?

INFO: rcu_sched self-detected stall on CPU { 5}  (t=10000 jiffies g=1735620=
 c=1735619 q=1601)
  CPU[  0]: TSTATE[0000000080001603] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/0:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[start_kernel+0x3d8/0x3e8]
  CPU[  1]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/1:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  2]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/2:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  3]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/3:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  4]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/4:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
* CPU[  5]: TSTATE[0000000080001601] TPC[00000000004513a0] TNPC[00000000004=
513a4] TASK[perl:23511]
             TPC[do_sparc64_fault+0x460/0x680] O7[do_sparc64_fault+0x410/0x=
680] I7[sparc64_realfault_common+0x10/0x20] RPC[schedule_tail+0x3c/0xa0]
  CPU[  6]: TSTATE[00000000f0001a07] TPC[00000000f7d553d0] TNPC[00000000f7d=
553d4] TASK[perl:23560]
             TPC[f7d553d0] O7[90944] I7[f50d8] RPC[f7d4e238]
  CPU[  7]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/7:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  8]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/8:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  9]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/9:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 10]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/10:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 11]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/11:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 12]: TSTATE[00000000f0001206] TPC[fffffc01006f2c78] TNPC[fffffc01006=
f2c5c] TASK[perl:23495]
             TPC[fffffc01006f2c78] O7[1c6abc] I7[1aee4c] RPC[1adb2c]
  CPU[ 13]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/13:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 14]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/14:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 15]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/15:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 16]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/16:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 17]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/17:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 18]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/18:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 19]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/19:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 20]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/20:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 21]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/21:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 22]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/22:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 23]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/23:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
type=1006 audit(1395882001.947:252): pid$376 uid=3D0 old auidB94967295 new =
auid=3D0 old sesB94967295 new ses%1 res=3D1
type=1006 audit(1395882001.947:253): pid$377 uid=3D0 old auidB94967295 new =
auid%121 old sesB94967295 new ses%2 res=3D1
INFO: rcu_sched self-detected stall on CPU { 5}  (t@004 jiffies g=1735620 c=
=1735619 q=9788)
  CPU[  0]: TSTATE[0000000080001603] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/0:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[start_kernel+0x3d8/0x3e8]
  CPU[  1]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/1:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  2]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/2:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  3]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/3:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  4]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/4:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
* CPU[  5]: TSTATE[0000000080001600] TPC[0000000000407a50] TNPC[00000000004=
07a54] TASK[perl:23511]
             TPC[sparc64_realfault_common+0x8/0x20] O7[ret_from_fork+0x4/0x=
2c] I7[schedule_tail+0x3c/0xa0] RPC[ret_from_fork+0x4/0x2c]
  CPU[  6]: TSTATE[00000000f0000205] TPC[000000000017dee8] TNPC[00000000001=
7deb0] TASK[perl:24122]
             TPC[17dee8] O7[388d] I7[181518] RPC[42b98c]
  CPU[  7]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/7:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  8]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/8:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  9]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/9:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 10]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/10:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 11]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/11:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 12]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/12:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 13]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/13:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 14]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/14:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 15]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/15:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 16]: TSTATE[00000000f0001a04] TPC[00000000000c492c] TNPC[00000000000=
c4930] TASK[perl:23730]
             TPC[c492c] O7[c48d0] I7[b1b50] RPC[b1b64]
  CPU[ 17]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/17:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 18]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/18:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 19]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/19:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 20]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/20:0]
INFO: rcu_sched detected stalls on CPUs/tasks: { 5} (detected by 13, t@006 =
jiffies, g=1735620, c=1735619, q=9788)
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 21]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/21:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 22]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/22:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 23]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/23:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  0]: TSTATE[0000000080001603] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/0:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[start_kernel+0x3d8/0x3e8]
  CPU[  1]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/1:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  2]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/2:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  3]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/3:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  4]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/4:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  5]: TSTATE[0000009911001604] TPC[000000000043cf10] TNPC[00000000004=
3cf14] TASK[perl:23511]
             TPC[xcall_deliver+0x10/0x140] O7[autoremove_wake_function+0x10=
/0x60] I7[try_to_wake_up+0x23c/0x300] RPC[autoremove_wake_function+0x10/0x6=
0]
  CPU[  6]: TSTATE[00000000f0000205] TPC[000000000017dee8] TNPC[00000000001=
7deb0] TASK[perl:24122]
             TPC[17dee8] O7[389f] I7[181518] RPC[42b98c]
  CPU[  7]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/7:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  8]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/8:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  9]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/9:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 10]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/10:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 11]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/11:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 12]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/12:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
* CPU[ 13]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/13:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 14]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/14:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 15]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/15:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 16]: TSTATE[00000044f0001a01] TPC[00000000000c33c8] TNPC[00000000000=
c33cc] TASK[perl:23730]
             TPC[c33c8] O7[c49a8] I7[b1c40] RPC[cd7b8]
  CPU[ 17]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/17:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 18]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/18:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 19]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/19:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 20]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/20:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 21]: TSTATE[0000004480001605] TPC[0000000000462e84] TNPC[00000000004=
62e88] TASK[swapper/21:0]
             TPC[irq_enter+0x64/0x80] O7[irq_enter+0x5c/0x80] I7[scheduler_=
ipi+0x20/0x40] RPC[tl0_irq2+0x14/0x20]
  CPU[ 22]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/22:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 23]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/23:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
INFO: rcu_sched self-detected stall on CPU { 5}  (tp009 jiffies g=1735620 c=
=1735619 q=17040)
  CPU[  0]: TSTATE[0000000080001603] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/0:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[start_kernel+0x3d8/0x3e8]
  CPU[  1]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/1:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  2]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/2:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  3]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/3:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  4]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/4:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
* CPU[  5]: TSTATE[0000004411001607] TPC[000000000048617c] TNPC[00000000004=
86180] TASK[perl:23511]
             TPC[schedule_tail+0x5c/0xa0] O7[schedule_tail+0x3c/0xa0] I7[re=
t_from_fork+0x4/0x2c] RPC[0xf7d7baf4]
  CPU[  6]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/6:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  7]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/7:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  8]: TSTATE[00000099f0000205] TPC[0000000000213618] TNPC[00000000002=
1361c] TASK[perl:26140]
             TPC[213618] O7[21e974] I7[214064] RPC[21e974]
  CPU[  9]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/9:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 10]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/10:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 11]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/11:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 12]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/12:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 13]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/13:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 14]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/14:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 15]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/15:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 16]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/16:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 17]: TSTATE[00000000f0001a02] TPC[00000000000cdfdc] TNPC[00000000000=
cdfe0] TASK[perl:23730]
             TPC[cdfdc] O7[cdfb8] I7[b1bd8] RPC[cd7b8]
  CPU[ 18]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/18:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 19]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/19:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 20]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/20:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 21]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/21:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
INFO: rcu_sched detected stalls on CPUs/tasks: { 5} (detected by 0, tp011 j=
iffies, g=1735620, c=1735619, q=17040)
  CPU[ 22]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/22:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 23]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/23:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
* CPU[  0]: TSTATE[0000000080001603] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/0:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[start_kernel+0x3d8/0x3e8]
  CPU[  1]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/1:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  2]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/2:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  3]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/3:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  4]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/4:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  5]: TSTATE[0000009911001604] TPC[00000000005fd1e0] TNPC[00000000005=
fd1e4] TASK[perl:23511]
             TPC[find_next_bit+0x80/0xe0] O7[try_to_wake_up+0x23c/0x300] I7=
[xcall_deliver+0xdc/0x140] RPC[try_to_wake_up+0x23c/0x300]
  CPU[  6]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/6:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  7]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/7:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  8]: TSTATE[00000099f0000205] TPC[0000000000213634] TNPC[00000000002=
13638] TASK[perl:26140]
             TPC[213634] O7[21e974] I7[2155d8] RPC[21e974]
  CPU[  9]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/9:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 10]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/10:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 11]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/11:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 12]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/12:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 13]: TSTATE[0000000080001602] TPC[00000000005f3418] TNPC[00000000005=
f341c] TASK[swapper/13:0]
             TPC[atomic64_add+0x8/0x54] O7[update_cfs_rq_blocked_load+0x118=
/0x160] I7[enqueue_entity+0x118/0x660] RPC[enqueue_task_fair+0x58/0x4c0]
  CPU[ 14]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/14:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 15]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/15:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 16]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/16:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 17]: TSTATE[00000000f0001a01] TPC[00000000000b1324] TNPC[00000000000=
b1b40] TASK[perl:23730]
             TPC[b1324] O7[b1b38] I7[cd7b8] RPC[cdfb8]
  CPU[ 18]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/18:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 19]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/19:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 20]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/20:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 21]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/21:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 22]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/22:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 23]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/23:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
INFO: rcu_sched self-detected stall on CPU { 5}  (t=100014 jiffies g=173562=
0 c=1735619 q$544)
  CPU[  0]: TSTATE[0000000080001603] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/0:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[start_kernel+0x3d8/0x3e8]
  CPU[  1]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/1:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  2]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/2:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  3]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/3:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  4]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/4:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
* CPU[  5]: TSTATE[0000004480001601] TPC[00000000004512e0] TNPC[00000000004=
f9ec0] TASK[perl:23511]
             TPC[do_sparc64_fault+0x3a0/0x680] O7[do_sparc64_fault+0x39c/0x=
680] I7[sparc64_realfault_common+0x10/0x20] RPC[schedule_tail+0x3c/0xa0]
  CPU[  6]: TSTATE[00000044f0001a02] TPC[00000000f7d4e260] TNPC[00000000f7d=
4e264] TASK[perl:23730]
             TPC[f7d4e260] O7[f7d4e238] I7[998cc] RPC[cd780]
  CPU[  7]: TSTATE[00000019f0001201] TPC[fffffc01006e6244] TNPC[fffffc01006=
e6248] TASK[perl:27169]
             TPC[fffffc01006e6244] O7[fffffc01006e6130] I7[fffffc01006e94f4=
] RPC[18e568]
  CPU[  8]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/8:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[  9]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/9:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 10]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/10:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 11]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/11:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 12]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/12:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 13]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/13:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 14]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/14:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
  CPU[ 15]: TSTATE[0000000080001602] TPC[000000000042c0b4] TNPC[00000000004=
2c0b8] TASK[swapper/15:0]
             TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x60/0xa0] I7[cp=
u_startup_entry+0x118/0x180] RPC[after_lock_tlb+0x1ac/0x1c4]
[...]
