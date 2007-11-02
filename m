From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 02 Nov 2007 15:37:25 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <472B4435.4050304@bzed.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060605080409080808090400"
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------060605080409080808090400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Thu, 01 Nov 2007 15:01:13 -0700 (PDT)
> 
>> I'm working on a kernel patch for 2.6.23 that will allow you to get
>> some useful debugging information in situations like this.
>>
>> I'll try to get you that patch by the end of tonight.
> 
> As promised, here is the patch below.

Thanks for the patch. Applied and used libnss-db + aptitude -u to hang
the machine.

I've sent g several times to sysrq, output is attached.
According to top the two hanging aptitude processes were running on CPU
1 + 3.

 3204 root      20   0 19552 5088 4072 R  100  0.1   6:54.49 1 aptitude
 3203 root      20   0 19552 5088 4072 R  100  0.1   6:56.39 3 aptitude


Cheers,

Bernd

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>

--------------060605080409080808090400
Content-Type: application/pgp-keys;
 name="sysrq-g.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq-g.txt"

Nov  2 16:25:30 titan kernel: [  977.969456] SysRq : Show Global CPU Regs
Nov  2 16:25:30 titan kernel: [  978.016149] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:25:30 titan kernel: [  978.134874]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:25:30 titan kernel: [  978.257809]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:25:30 titan kernel: [  978.323404]   CPU[  2]: TSTATE[0000000811009606] TPC[000000000067d028] TNPC[000000000067d02c] TASK[klogd:2754]
Nov  2 16:25:30 titan kernel: [  978.443206]              TPC[_spin_lock_irqsave+0xc/0x24]
Nov  2 16:25:30 titan kernel: [  978.507778]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:25:30 titan kernel: [  978.630707]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:25:44 titan kernel: [  992.287714] SysRq : Show Global CPU Regs
Nov  2 16:25:44 titan kernel: [  992.334419] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:25:44 titan kernel: [  992.453169]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:25:44 titan kernel: [  992.576089]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:25:44 titan kernel: [  992.641700]   CPU[  2]: TSTATE[0000004411009606] TPC[000000000067b52c] TNPC[000000000067b530] TASK[klogd:2754]
Nov  2 16:25:45 titan kernel: [  992.761499]              TPC[schedule+0x648/0x7a4]
Nov  2 16:25:45 titan kernel: [  992.818782]   CPU[  3]: TSTATE[0000000011009606] TPC[000000000042fb8c] TNPC[000000000042fb90] TASK[aptitude:3203]
Nov  2 16:25:45 titan kernel: [  992.941718]              TPC[__delay+0x24/0x48]
Nov  2 16:25:53 titan kernel: [ 1001.515758] SysRq : Show Global CPU Regs
Nov  2 16:25:53 titan kernel: [ 1001.562557] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:25:53 titan kernel: [ 1001.681306]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:25:54 titan kernel: [ 1001.804225]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:25:54 titan kernel: [ 1001.869838]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b528] TNPC[000000000067b52c] TASK[klogd:2754]
Nov  2 16:25:54 titan kernel: [ 1001.989634]              TPC[schedule+0x644/0x7a4]
Nov  2 16:25:54 titan kernel: [ 1002.046918]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:25:54 titan kernel: [ 1002.169846]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:25:56 titan kernel: [ 1004.637099] SysRq : Show Global CPU Regs
Nov  2 16:25:57 titan kernel: [ 1004.683879] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:25:57 titan kernel: [ 1004.802630]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2d8] TNPC[000000000067d2dc] TASK[aptitude:3204]
Nov  2 16:25:57 titan kernel: [ 1004.925549]              TPC[_write_unlock_irq+0x18/0x110]
Nov  2 16:25:57 titan kernel: [ 1004.991161]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4dc] TNPC[000000000067b4e0] TASK[swapper:0]
Nov  2 16:25:57 titan kernel: [ 1005.109918]              TPC[schedule+0x5f8/0x7a4]
Nov  2 16:25:57 titan kernel: [ 1005.167201]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:25:57 titan kernel: [ 1005.290127]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:25:58 titan kernel: [ 1006.437886] SysRq : Show Global CPU Regs
Nov  2 16:25:58 titan kernel: [ 1006.484692] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:25:58 titan kernel: [ 1006.603445]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:25:59 titan kernel: [ 1006.726363]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:25:59 titan kernel: [ 1006.791977]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4dc] TNPC[000000000067b4e0] TASK[swapper:0]
Nov  2 16:25:59 titan kernel: [ 1006.910734]              TPC[schedule+0x5f8/0x7a4]
Nov  2 16:25:59 titan kernel: [ 1006.968016]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:25:59 titan kernel: [ 1007.090941]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:00 titan kernel: [ 1008.130639] SysRq : Show Global CPU Regs
Nov  2 16:26:00 titan kernel: [ 1008.177384] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:00 titan kernel: [ 1008.296136]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:00 titan kernel: [ 1008.419054]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:00 titan kernel: [ 1008.484668]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4e0] TNPC[000000000067b4e4] TASK[swapper:0]
Nov  2 16:26:00 titan kernel: [ 1008.603424]              TPC[schedule+0x5fc/0x7a4]
Nov  2 16:26:00 titan kernel: [ 1008.660708]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:01 titan kernel: [ 1008.783633]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:01 titan ntpd[2782]: adjusting local clock by -0.184097s
Nov  2 16:26:01 titan kernel: [ 1009.663330] SysRq : Show Global CPU Regs
Nov  2 16:26:02 titan kernel: [ 1009.710081] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:02 titan kernel: [ 1009.828829]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:02 titan kernel: [ 1009.951749]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:02 titan kernel: [ 1010.017361]   CPU[  2]: TSTATE[0000009911009606] TPC[00000000005465f8] TNPC[00000000005465fc] TASK[klogd:2754]
Nov  2 16:26:02 titan kernel: [ 1010.137171]              TPC[atomic_sub_ret+0x0/0x30]
Nov  2 16:26:02 titan kernel: [ 1010.197567]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:02 titan kernel: [ 1010.320492]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:03 titan kernel: [ 1011.075939] SysRq : Show Global CPU Regs
Nov  2 16:26:03 titan kernel: [ 1011.122773] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:03 titan kernel: [ 1011.241523]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:03 titan kernel: [ 1011.364441]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:03 titan kernel: [ 1011.430054]   CPU[  2]: TSTATE[0000004411009604] TPC[00000000004572b8] TNPC[00000000004572bc] TASK[swapper:0]
Nov  2 16:26:03 titan kernel: [ 1011.548823]              TPC[update_stats_wait_end+0x60/0x88]
Nov  2 16:26:03 titan kernel: [ 1011.617554]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:04 titan kernel: [ 1011.740477]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:04 titan kernel: [ 1012.720665] SysRq : Show Global CPU Regs
Nov  2 16:26:05 titan kernel: [ 1012.767444] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:05 titan kernel: [ 1012.886194]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:05 titan kernel: [ 1013.009113]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:05 titan kernel: [ 1013.074726]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4f4] TNPC[000000000067b4f8] TASK[swapper:0]
Nov  2 16:26:05 titan kernel: [ 1013.193482]              TPC[schedule+0x610/0x7a4]
Nov  2 16:26:05 titan kernel: [ 1013.250767]   CPU[  3]: TSTATE[0000000011009605] TPC[000000000042fbb0] TNPC[000000000042fbb4] TASK[aptitude:3203]
Nov  2 16:26:05 titan kernel: [ 1013.373693]              TPC[udelay+0x0/0x1c]
Nov  2 16:26:06 titan kernel: [ 1014.109287] SysRq : Show Global CPU Regs
Nov  2 16:26:06 titan kernel: [ 1014.156075] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:06 titan kernel: [ 1014.274826]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:06 titan kernel: [ 1014.397745]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:06 titan kernel: [ 1014.463358]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b50c] TNPC[000000000067b510] TASK[klogd:2754]
Nov  2 16:26:06 titan kernel: [ 1014.583156]              TPC[schedule+0x628/0x7a4]
Nov  2 16:26:06 titan kernel: [ 1014.640439]   CPU[  3]: TSTATE[0000000011009605] TPC[0000000000441a00] TNPC[0000000000441a04] TASK[aptitude:3203]
Nov  2 16:26:07 titan kernel: [ 1014.763366]              TPC[cheetah_xcall_deliver+0x17c/0x23c]
Nov  2 16:26:11 titan kernel: [ 1019.023453] SysRq : Show Global CPU Regs
Nov  2 16:26:11 titan kernel: [ 1019.070193] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:11 titan kernel: [ 1019.188944]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2d8] TNPC[000000000067d2dc] TASK[aptitude:3204]
Nov  2 16:26:11 titan kernel: [ 1019.311862]              TPC[_write_unlock_irq+0x18/0x110]
Nov  2 16:26:11 titan kernel: [ 1019.377477]   CPU[  2]: TSTATE[0000009911009602] TPC[0000000000407af0] TNPC[0000000000407af4] TASK[swapper:0]
Nov  2 16:26:11 titan kernel: [ 1019.496236]              TPC[__tsb_context_switch+0xf0/0x100]
Nov  2 16:26:11 titan kernel: [ 1019.564974]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:11 titan kernel: [ 1019.687898]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:12 titan kernel: [ 1020.280001] SysRq : Show Global CPU Regs
Nov  2 16:26:12 titan kernel: [ 1020.326848] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:12 titan kernel: [ 1020.445599]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:12 titan kernel: [ 1020.568516]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:12 titan kernel: [ 1020.634131]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4e0] TNPC[000000000067b4e4] TASK[swapper:0]
Nov  2 16:26:13 titan kernel: [ 1020.752886]              TPC[schedule+0x5fc/0x7a4]
Nov  2 16:26:13 titan kernel: [ 1020.810170]   CPU[  3]: TSTATE[0000004411009606] TPC[000000000053a024] TNPC[000000000053a028] TASK[aptitude:3203]
Nov  2 16:26:13 titan kernel: [ 1020.933105]              TPC[__first_cpu+0x4/0x28]
Nov  2 16:26:17 titan kernel: [ 1025.630375] SysRq : Show Global CPU Regs
Nov  2 16:26:17 titan kernel: [ 1025.677109] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:17 titan kernel: [ 1025.795860]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:18 titan kernel: [ 1025.918776]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:18 titan kernel: [ 1025.984391]   CPU[  2]: TSTATE[0000009911009602] TPC[0000000000407af0] TNPC[0000000000407af4] TASK[swapper:0]
Nov  2 16:26:18 titan kernel: [ 1026.103148]              TPC[__tsb_context_switch+0xf0/0x100]
Nov  2 16:26:18 titan kernel: [ 1026.171888]   CPU[  3]: TSTATE[0000004411009606] TPC[000000000053a03c] TNPC[000000000053a040] TASK[aptitude:3203]
Nov  2 16:26:18 titan kernel: [ 1026.294813]              TPC[__first_cpu+0x1c/0x28]
Nov  2 16:26:19 titan kernel: [ 1027.271082] SysRq : Show Global CPU Regs
Nov  2 16:26:19 titan kernel: [ 1027.317924] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:19 titan kernel: [ 1027.436675]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:19 titan kernel: [ 1027.559592]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:19 titan kernel: [ 1027.625206]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4dc] TNPC[000000000067b4e0] TASK[swapper:0]
Nov  2 16:26:20 titan kernel: [ 1027.743964]              TPC[schedule+0x5f8/0x7a4]
Nov  2 16:26:20 titan kernel: [ 1027.801247]   CPU[  3]: TSTATE[0000000011009605] TPC[000000000042fbbc] TNPC[000000000042fbc0] TASK[aptitude:3203]
Nov  2 16:26:20 titan kernel: [ 1027.924173]              TPC[udelay+0xc/0x1c]
Nov  2 16:26:20 titan kernel: [ 1028.551652] SysRq : Show Global CPU Regs
Nov  2 16:26:20 titan kernel: [ 1028.598432] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:20 titan kernel: [ 1028.717185]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:21 titan kernel: [ 1028.840100]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:21 titan kernel: [ 1028.905716]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4f4] TNPC[000000000067b4f8] TASK[swapper:0]
Nov  2 16:26:21 titan kernel: [ 1029.024471]              TPC[schedule+0x610/0x7a4]
Nov  2 16:26:21 titan kernel: [ 1029.081754]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:21 titan kernel: [ 1029.204680]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:22 titan kernel: [ 1029.892247] SysRq : Show Global CPU Regs
Nov  2 16:26:22 titan kernel: [ 1029.939044] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:22 titan kernel: [ 1030.057796]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:22 titan kernel: [ 1030.180714]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:22 titan kernel: [ 1030.246327]   CPU[  2]: TSTATE[0000009911009602] TPC[000000000067b348] TNPC[000000000067b34c] TASK[swapper:0]
Nov  2 16:26:22 titan kernel: [ 1030.365083]              TPC[schedule+0x464/0x7a4]
Nov  2 16:26:22 titan kernel: [ 1030.422365]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:22 titan kernel: [ 1030.545292]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:23 titan kernel: [ 1031.344895] SysRq : Show Global CPU Regs
Nov  2 16:26:23 titan kernel: [ 1031.391737] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:23 titan kernel: [ 1031.510489]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:23 titan kernel: [ 1031.633406]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:23 titan kernel: [ 1031.699020]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4e4] TNPC[000000000067b4e8] TASK[swapper:0]
Nov  2 16:26:24 titan kernel: [ 1031.817778]              TPC[schedule+0x600/0x7a4]
Nov  2 16:26:24 titan kernel: [ 1031.875061]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:24 titan kernel: [ 1031.997983]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:24 titan kernel: [ 1032.621456] SysRq : Show Global CPU Regs
Nov  2 16:26:24 titan kernel: [ 1032.668289] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:24 titan kernel: [ 1032.787038]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:25 titan kernel: [ 1032.909958]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:25 titan kernel: [ 1032.975572]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4e4] TNPC[000000000067b4e8] TASK[swapper:0]
Nov  2 16:26:25 titan kernel: [ 1033.094327]              TPC[schedule+0x600/0x7a4]
Nov  2 16:26:25 titan kernel: [ 1033.151610]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:25 titan kernel: [ 1033.274534]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:26 titan kernel: [ 1034.030048] SysRq : Show Global CPU Regs
Nov  2 16:26:26 titan kernel: [ 1034.076812] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:26 titan kernel: [ 1034.195568]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:26 titan kernel: [ 1034.318485]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:26 titan kernel: [ 1034.384097]   CPU[  2]: TSTATE[0000004411009604] TPC[00000000004572b8] TNPC[00000000004572bc] TASK[swapper:0]
Nov  2 16:26:26 titan kernel: [ 1034.502856]              TPC[update_stats_wait_end+0x60/0x88]
Nov  2 16:26:26 titan kernel: [ 1034.571597]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:26 titan kernel: [ 1034.694518]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:27 titan kernel: [ 1035.434682] SysRq : Show Global CPU Regs
Nov  2 16:26:27 titan kernel: [ 1035.481488] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:27 titan kernel: [ 1035.600240]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:27 titan kernel: [ 1035.723159]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:27 titan kernel: [ 1035.788772]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4e4] TNPC[000000000067b4e8] TASK[swapper:0]
Nov  2 16:26:28 titan kernel: [ 1035.907527]              TPC[schedule+0x600/0x7a4]
Nov  2 16:26:28 titan kernel: [ 1035.964812]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:28 titan kernel: [ 1036.087735]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:28 titan kernel: [ 1036.763398] SysRq : Show Global CPU Regs
Nov  2 16:26:29 titan kernel: [ 1036.810225] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:29 titan kernel: [ 1036.928976]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:29 titan kernel: [ 1037.051894]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:29 titan kernel: [ 1037.117508]   CPU[  2]: TSTATE[0000000011009603] TPC[000000000044d604] TNPC[000000000044d608] TASK[swapper:0]
Nov  2 16:26:29 titan kernel: [ 1037.236267]              TPC[flush_tlb_pending+0x4/0x68]
Nov  2 16:26:29 titan kernel: [ 1037.299798]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:29 titan kernel: [ 1037.422722]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:30 titan kernel: [ 1038.215901] SysRq : Show Global CPU Regs
Nov  2 16:26:30 titan kernel: [ 1038.262707] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:30 titan kernel: [ 1038.381462]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:30 titan kernel: [ 1038.504381]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:30 titan kernel: [ 1038.569995]   CPU[  2]: TSTATE[0000004411009604] TPC[00000000004572b8] TNPC[00000000004572bc] TASK[swapper:0]
Nov  2 16:26:30 titan kernel: [ 1038.688753]              TPC[update_stats_wait_end+0x60/0x88]
Nov  2 16:26:30 titan kernel: [ 1038.757491]   CPU[  3]: TSTATE[0000000011009606] TPC[000000000042fb8c] TNPC[000000000042fb90] TASK[aptitude:3203]
Nov  2 16:26:31 titan kernel: [ 1038.880417]              TPC[__delay+0x24/0x48]
Nov  2 16:26:31 titan kernel: [ 1039.576520] SysRq : Show Global CPU Regs
Nov  2 16:26:31 titan kernel: [ 1039.623322] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:31 titan kernel: [ 1039.742075]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2d8] TNPC[000000000067d2dc] TASK[aptitude:3204]
Nov  2 16:26:32 titan kernel: [ 1039.864993]              TPC[_write_unlock_irq+0x18/0x110]
Nov  2 16:26:32 titan kernel: [ 1039.930605]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4e4] TNPC[000000000067b4e8] TASK[swapper:0]
Nov  2 16:26:32 titan kernel: [ 1040.049361]              TPC[schedule+0x600/0x7a4]
Nov  2 16:26:32 titan kernel: [ 1040.106645]   CPU[  3]: TSTATE[0000000011009605] TPC[000000000042fbc4] TNPC[000000000042fb68] TASK[aptitude:3203]
Nov  2 16:26:32 titan kernel: [ 1040.229570]              TPC[udelay+0x14/0x1c]
Nov  2 16:26:33 titan kernel: [ 1040.957133] SysRq : Show Global CPU Regs
Nov  2 16:26:33 titan kernel: [ 1041.003934] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:33 titan kernel: [ 1041.122676]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2d8] TNPC[000000000067d2dc] TASK[aptitude:3204]
Nov  2 16:26:33 titan kernel: [ 1041.245604]              TPC[_write_unlock_irq+0x18/0x110]
Nov  2 16:26:33 titan kernel: [ 1041.311216]   CPU[  2]: TSTATE[0000004411009606] TPC[000000000067b52c] TNPC[000000000067b530] TASK[klogd:2754]
Nov  2 16:26:33 titan kernel: [ 1041.431014]              TPC[schedule+0x648/0x7a4]
Nov  2 16:26:33 titan kernel: [ 1041.488298]   CPU[  3]: TSTATE[0000000011009605] TPC[000000000042fbac] TNPC[0000000000441a44] TASK[aptitude:3203]
Nov  2 16:26:33 titan kernel: [ 1041.611223]              TPC[__delay+0x44/0x48]
Nov  2 16:26:34 titan kernel: [ 1042.481780] SysRq : Show Global CPU Regs
Nov  2 16:26:34 titan kernel: [ 1042.528603] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:34 titan kernel: [ 1042.647357]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:35 titan kernel: [ 1042.770274]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:35 titan kernel: [ 1042.835889]   CPU[  2]: TSTATE[0000009911009602] TPC[000000000067b348] TNPC[000000000067b34c] TASK[swapper:0]
Nov  2 16:26:35 titan kernel: [ 1042.954644]              TPC[schedule+0x464/0x7a4]
Nov  2 16:26:35 titan kernel: [ 1043.011928]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:35 titan kernel: [ 1043.134851]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:35 titan kernel: [ 1043.770375] SysRq : Show Global CPU Regs
Nov  2 16:26:36 titan kernel: [ 1043.817135] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:36 titan kernel: [ 1043.935886]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:36 titan kernel: [ 1044.058806]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:36 titan kernel: [ 1044.124419]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4e8] TNPC[000000000067b4ec] TASK[swapper:0]
Nov  2 16:26:36 titan kernel: [ 1044.243174]              TPC[schedule+0x604/0x7a4]
Nov  2 16:26:36 titan kernel: [ 1044.300458]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:36 titan kernel: [ 1044.423380]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:37 titan kernel: [ 1045.070943] SysRq : Show Global CPU Regs
Nov  2 16:26:37 titan kernel: [ 1045.117745] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:37 titan kernel: [ 1045.236498]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:37 titan kernel: [ 1045.359418]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:37 titan kernel: [ 1045.425029]   CPU[  2]: TSTATE[0000004411009604] TPC[000000000045727c] TNPC[0000000000457280] TASK[swapper:0]
Nov  2 16:26:37 titan kernel: [ 1045.543790]              TPC[update_stats_wait_end+0x24/0x88]
Nov  2 16:26:38 titan kernel: [ 1045.612529]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:38 titan kernel: [ 1045.735452]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:39 titan kernel: [ 1046.359508] SysRq : Show Global CPU Regs
Nov  2 16:26:39 titan kernel: [ 1046.406277] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:39 titan kernel: [ 1046.525027]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:39 titan kernel: [ 1046.647946]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:39 titan kernel: [ 1046.713558]   CPU[  2]: TSTATE[0000009911009606] TPC[00000000005465f8] TNPC[00000000005465fc] TASK[klogd:2754]
Nov  2 16:26:39 titan kernel: [ 1046.833360]              TPC[atomic_sub_ret+0x0/0x30]
Nov  2 16:26:39 titan kernel: [ 1046.893765]   CPU[  3]: TSTATE[0000004411009605] TPC[0000000000441a50] TNPC[0000000000441a9c] TASK[aptitude:3203]
Nov  2 16:26:39 titan kernel: [ 1047.016689]              TPC[cheetah_xcall_deliver+0x1cc/0x23c]
Nov  2 16:26:40 titan kernel: [ 1047.584036] SysRq : Show Global CPU Regs
Nov  2 16:26:40 titan kernel: [ 1047.630844] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:40 titan kernel: [ 1047.749598]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:40 titan kernel: [ 1047.872516]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:40 titan kernel: [ 1047.938129]   CPU[  2]: TSTATE[0000004411009604] TPC[000000000045727c] TNPC[0000000000457280] TASK[swapper:0]
Nov  2 16:26:40 titan kernel: [ 1048.056888]              TPC[update_stats_wait_end+0x24/0x88]
Nov  2 16:26:40 titan kernel: [ 1048.125629]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:40 titan kernel: [ 1048.248553]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:41 titan kernel: [ 1048.800594] SysRq : Show Global CPU Regs
Nov  2 16:26:41 titan kernel: [ 1048.847399] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:41 titan kernel: [ 1048.966150]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:41 titan kernel: [ 1049.089067]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:41 titan kernel: [ 1049.154679]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4dc] TNPC[000000000067b4e0] TASK[swapper:0]
Nov  2 16:26:41 titan kernel: [ 1049.273436]              TPC[schedule+0x5f8/0x7a4]
Nov  2 16:26:41 titan kernel: [ 1049.330723]   CPU[  3]: TSTATE[0000000011009606] TPC[000000000042fb94] TNPC[000000000042fa10] TASK[aptitude:3203]
Nov  2 16:26:41 titan kernel: [ 1049.453648]              TPC[__delay+0x2c/0x48]
Nov  2 16:26:42 titan kernel: [ 1049.969110] SysRq : Show Global CPU Regs
Nov  2 16:26:42 titan kernel: [ 1050.015927] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:42 titan kernel: [ 1050.134678]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2dc] TNPC[000000000067d2e0] TASK[aptitude:3204]
Nov  2 16:26:42 titan kernel: [ 1050.257597]              TPC[_write_unlock_irq+0x1c/0x110]
Nov  2 16:26:42 titan kernel: [ 1050.323212]   CPU[  2]: TSTATE[0000004411009604] TPC[00000000004572b8] TNPC[00000000004572bc] TASK[swapper:0]
Nov  2 16:26:42 titan kernel: [ 1050.441968]              TPC[update_stats_wait_end+0x60/0x88]
Nov  2 16:26:42 titan kernel: [ 1050.510708]   CPU[  3]: TSTATE[0000004411009605] TPC[0000000000441a50] TNPC[0000000000441a9c] TASK[aptitude:3203]
Nov  2 16:26:42 titan kernel: [ 1050.633633]              TPC[cheetah_xcall_deliver+0x1cc/0x23c]
Nov  2 16:26:43 titan kernel: [ 1051.025572] SysRq : Show Global CPU Regs
Nov  2 16:26:43 titan kernel: [ 1051.072377] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:43 titan kernel: [ 1051.191126]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:43 titan kernel: [ 1051.314046]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:43 titan kernel: [ 1051.379658]   CPU[  2]: TSTATE[0000004411009602] TPC[000000000067b4dc] TNPC[000000000067b4e0] TASK[swapper:0]
Nov  2 16:26:43 titan kernel: [ 1051.498414]              TPC[schedule+0x5f8/0x7a4]
Nov  2 16:26:43 titan kernel: [ 1051.555699]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:43 titan kernel: [ 1051.678621]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:45 titan kernel: [ 1052.102029] SysRq : Show Global CPU Regs
Nov  2 16:26:45 titan kernel: [ 1052.148821] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:45 titan kernel: [ 1052.267574]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2d8] TNPC[000000000067d2dc] TASK[aptitude:3204]
Nov  2 16:26:45 titan kernel: [ 1052.390492]              TPC[_write_unlock_irq+0x18/0x110]
Nov  2 16:26:45 titan kernel: [ 1052.456107]   CPU[  2]: TSTATE[0000004411009604] TPC[00000000004572b8] TNPC[00000000004572bc] TASK[swapper:0]
Nov  2 16:26:45 titan kernel: [ 1052.574865]              TPC[update_stats_wait_end+0x60/0x88]
Nov  2 16:26:45 titan kernel: [ 1052.643604]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:45 titan kernel: [ 1052.766529]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  2 16:26:46 titan kernel: [ 1053.154503] SysRq : Show Global CPU Regs
Nov  2 16:26:46 titan kernel: [ 1053.201315] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3117]
Nov  2 16:26:46 titan kernel: [ 1053.320065]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:26:46 titan kernel: [ 1053.442982]              TPC[_write_unlock_irq+0x20/0x110]
Nov  2 16:26:46 titan kernel: [ 1053.508596]   CPU[  2]: TSTATE[0000009911009606] TPC[00000000005465f8] TNPC[00000000005465fc] TASK[klogd:2754]
Nov  2 16:26:46 titan kernel: [ 1053.628396]              TPC[atomic_sub_ret+0x0/0x30]
Nov  2 16:26:46 titan kernel: [ 1053.688801]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:26:46 titan kernel: [ 1053.811727]              TPC[cheetah_xcall_deliver+0x174/0x23c]

--------------060605080409080808090400--
