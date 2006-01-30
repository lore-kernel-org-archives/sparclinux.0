From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 30 Jan 2006 09:19:49 +0000
Subject: Re: Attempts to set date with 'date -s' hang the machine
Message-Id: <20060130.011949.24946534.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0601300019430.4017@bobcat>
In-Reply-To: <Pine.LNX.4.63.0601300019430.4017@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 30 Jan 2006 00:34:51 -0800 (PST)

> get_compat_timespec: ts=FFfff800bf7a7e80
> get_compat_timespec: ts->tv_sec=FFfff800bf7a7e80
> get_compat_timespec: ts->tv_nsec=FFfff800bf7a7e88
> get_compat_timespec: cts=FFffffffef8d7cd8
> get_compat_timespec: cts->tv_sec=FFffffffef8d7cd8
> get_compat_timespec: cts->tv_nsec=FFffffffef8d7cdc
>=20
> I've also got the debugging output from a few other (successful)
> calls to get_compat_timespec(), the output then typically looks=20
> like that:
>=20
> get_compat_timespec: ts=FFfff800bfbc7e80
> get_compat_timespec: ts->tv_sec=FFfff800bfbc7e80
> get_compat_timespec: ts->tv_nsec=FFfff800bfbc7e88
> get_compat_timespec: cts=00000000efa23c88
> get_compat_timespec: cts->tv_sec=00000000efa23c88
> get_compat_timespec: cts->tv_nsec=00000000efa23c8c
>=20
> Here the higher byte of the cts is set to zero, as I believe it should be=
=20
> for a userspace address. In the failing case the upper byte is set to
> ffffffff, which probably causes the problem. I'd appreciate any ideas on =

> how to resolve this issue.

In the first case get_compat_timespec() is being called with user
pointers which have been sign extended, and that's the bug.

A simple tree-wide grep for compat_sys_clock_settime() shows where
this is occuring, in arch/sparc64/kernel/sys32.S with this compat
syscall stub:

SIGN1(sys32_clock_settime, compat_sys_clock_settime, %o1)

Which is extending the pointer second arg.  In fact no sign extensions
are actually necessary here, so this stub can just be completely
eliminated.

This patch does that, and should fix this bug.

diff --git a/arch/sparc64/kernel/sys32.S b/arch/sparc64/kernel/sys32.S
index 9cd272a..60b5937 100644
--- a/arch/sparc64/kernel/sys32.S
+++ b/arch/sparc64/kernel/sys32.S
@@ -84,7 +84,6 @@ SIGN2(sys32_fadvise64_64, compat_sys_fad
 SIGN2(sys32_bdflush, sys_bdflush, %o0, %o1)
 SIGN1(sys32_mlockall, sys_mlockall, %o0)
 SIGN1(sys32_nfsservctl, compat_sys_nfsservctl, %o0)
-SIGN1(sys32_clock_settime, compat_sys_clock_settime, %o1)
 SIGN1(sys32_clock_nanosleep, compat_sys_clock_nanosleep, %o1)
 SIGN1(sys32_timer_settime, compat_sys_timer_settime, %o1)
 SIGN1(sys32_io_submit, compat_sys_io_submit, %o1)
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index bf0fc5b..2881faf 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -71,7 +71,7 @@ sys_call_table32:
 /*240*/	.word sys_munlockall, sys32_sched_setparam, sys32_sched_getparam, =
sys32_sched_setscheduler, sys32_sched_getscheduler
 	.word sys_sched_yield, sys32_sched_get_priority_max, sys32_sched_get_prio=
rity_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys32_getsid, sys_fdatasync, sys=
32_nfsservctl
-	.word sys_ni_syscall, sys32_clock_settime, compat_sys_clock_gettime, comp=
at_sys_clock_getres, sys32_clock_nanosleep
+	.word sys_ni_syscall, compat_sys_clock_settime, compat_sys_clock_gettime,=
 compat_sys_clock_getres, sys32_clock_nanosleep
 /*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, =
sys32_timer_settime, compat_sys_timer_gettime, sys_timer_getoverrun
 	.word sys_timer_delete, compat_sys_timer_create, sys_ni_syscall, compat_s=
ys_io_setup, sys_io_destroy
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys=
32_mq_open, sys_mq_unlink

