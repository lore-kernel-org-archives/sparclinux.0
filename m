From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 19 Jan 2005 19:48:37 +0000
Subject: FPU context and fork
Message-Id: <41EEB995.8070402@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I struggle to build a self-compiled toolchain and glibc for Sparcstation 
20 M612. I am running testsuite for both and I run into a failure from 
test-fenv test from glibc testsuite. This is a test of FP exceptions 
(IEEE 754 compliant) -each exception is disabled or enabled and checked 
if a handler is called when the exception is raised.

The test fails with 11 errors on UP kernel 2.4.27. This is probably 
incorrect as SuperSparc should be IEEE 754 compliant. But a problem is 
that it fails with 21 errors on SMP kernel 2.4.27. I suppose that a 
different behavior between UP and SMP version is a serious bug. I see it 
is done the same way in 2.6.10 series.

 I dug into a problem and found that it comes from not copying the FPU 
state in do_fork function. Actually, the FPU is disabled in every new 
created task and enabled later when the FPU operation is done. So the 
glibc test must have failed, because it enables or disables FP 
exceptions than forks and wait for the FP exception signal. After the 
fork, the FPU in the new task is initialized to a default state so 
rounding and exception settings are lost.

I also observed that a system of handling FPU context reloading is 
different in SMP and UP version.

I did a little research on Internet and found that FPU context 
initialization and reloading happened to other architectures (MIPS, SH) 
too. Various arguments were given how it should be done.

How  should it be done?  Should copy_flags() during do_fork() preserve 
FPU context/registers for child task? Should SMP and UP context 
switching be handled differently?

I am eager to fix this,
Krzysztof Helt




