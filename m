From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 20 Oct 2015 20:40:34 +0000
Subject: sparc crashes in -next due to 'of/platform: Point to struct device from device node'
Message-Id: <5626A6C2.4010706@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

I see the following sparc/sparc64 runtime crashes since next-20151016.
The problem is seen with sparc32_defconfig and sparc64_defconfig
(the traceback is a bit different for sparc64).

NET: Registered protocol family 16
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
swapper/0(1): Oops [#1]
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc1-00003-g61e82530d80f #1
task: f681da20 ti: f681e000 task.ti: f681e000
PSR: 408010c6 PC: f0417a10 NPC: f0417a28 Y: 00000000    Not tainted
PC: <iommu_init+0x60/0x208>
%G: f6844000 00008000  00461000 0000006c  00000017 00000076  f681e000 00697400
%O: f687a600 000000d0  f681fe2c 00000000  f6800040 404010e6  f681fd80 f0417a00
RPC: <iommu_init+0x50/0x208>
%L: f0440800 f687a600  00000000 00000002  f04408a4 00000000  f03f8f94 00000000
%I: f03a6190 f0000000  f03a6210 f03a6160  f0437400 f088b120  f681fde0 f000a0ec
Disabling lock debugging due to kernel taint
Caller[f000a0ec]: do_one_initcall+0x84/0x1e8
Caller[f0410094]: kernel_init_freeable+0x130/0x1e0
Caller[f034244c]: kernel_init+0x4/0xf4
Caller[f000b4d4]: ret_from_kernel_thread+0xc/0x38
Caller[00000000]:   (null)
Instruction DUMP: d0052018  a2922000  32800007 <d004a0f4> 113c0e98  7ff6159e  90122168  7ff61511  01000000
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

Bisect points to "of/platform: Point to struct device from device node".
Bisect log is below. Reverting this patch results in build failures, so
I could not test if a revert would fix the problem.

Guenter

---
$ git bisect log
# bad: [1c7a47a97a31902a96fd4ec9e930af23cca3d67d] Add linux-next specific files for 20151020
# good: [7379047d5585187d1288486d4627873170d0005a] Linux 4.3-rc6
git bisect start 'HEAD' 'v4.3-rc6'
# good: [0e3a82ce0a0479cb4d7a6cca303942fe95b37687] Merge remote-tracking branch 'md/for-next'
git bisect good 0e3a82ce0a0479cb4d7a6cca303942fe95b37687
# good: [c3af8a28f43315fc46753465a4e77e5619dd9f30] staging: IB/hfi1: use TASK_COMM_LEN in hfi1_ctxtdata
git bisect good c3af8a28f43315fc46753465a4e77e5619dd9f30
# bad: [75a52ca1c066307d4a9a4b42a20a7640b0e81fe4] Merge remote-tracking branch 'driver-core/driver-core-next'
git bisect bad 75a52ca1c066307d4a9a4b42a20a7640b0e81fe4
# good: [d3f683641ad30eecfca7599abfd2baefe763c72f] Merge branch 'x86/urgent'
git bisect good d3f683641ad30eecfca7599abfd2baefe763c72f
# bad: [00e16fdd52add4874c585e2fc3d8f28bb2bb8ca5] Merge remote-tracking branch 'mailbox/mailbox-for-next'
git bisect bad 00e16fdd52add4874c585e2fc3d8f28bb2bb8ca5
# good: [a5e241ac9f2df39200df1ea06392c7d801f6b127] Merge remote-tracking branch 'regulator/for-next'
git bisect good a5e241ac9f2df39200df1ea06392c7d801f6b127
# good: [3ea73388f1d40169b9cfcce578991a9c3c33d0be] Merge remote-tracking branch 'dwmw2-iommu/master'
git bisect good 3ea73388f1d40169b9cfcce578991a9c3c33d0be
# good: [15800f083f028b6df640ea258014458b8c3d805c] Merge remote-tracking branch 'audit/next'
git bisect good 15800f083f028b6df640ea258014458b8c3d805c
# good: [0f1cba62520b611914e0365e8487e12bee5a651e] Merge branch 'dt-doc-cleanup' into for-next
git bisect good 0f1cba62520b611914e0365e8487e12bee5a651e
# bad: [dd915c6fd3f9df40906dbf432e587b2e7a175b3a] clk: Probe clk providers on demand
git bisect bad dd915c6fd3f9df40906dbf432e587b2e7a175b3a
# bad: [5634acd9c8e3cd43767978a7987762390d0b7e18] regulator: core: Probe regulators on demand
git bisect bad 5634acd9c8e3cd43767978a7987762390d0b7e18
# bad: [61e82530d80f05591cba20687aad50010eef45e3] of/platform: Point to struct device from device node
git bisect bad 61e82530d80f05591cba20687aad50010eef45e3
# good: [f7d5891639697aa3d4aa319d2b2e88d536ba1276] ARM: amba: Move reading of periphid to amba_match()
git bisect good f7d5891639697aa3d4aa319d2b2e88d536ba1276
# first bad commit: [61e82530d80f05591cba20687aad50010eef45e3] of/platform: Point to struct device from device node
