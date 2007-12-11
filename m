From: David Miller <davem@davemloft.net>
Date: Tue, 11 Dec 2007 10:15:49 +0000
Subject: Re: 2.6.24-rc4-mm1: undefined reference to `compat_sys_timerfd' on
Message-Id: <20071211.021549.126640032.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<200712080104.55619.m.kozlowski@tuxland.pl>
	<20071207160800.77e7e907.akpm@linux-foundation.org>
In-Reply-To: <20071207160800.77e7e907.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: m.kozlowski@tuxland.pl, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 7 Dec 2007 16:08:00 -0800

> Or should this have been sys_nis_syscall()?

sys_nis_syscall() was used in cases on sparc where we wanted
to get a log of invocations of unimplemented syscalls, as it
aided debugging and anaylsis.

But the usefulness of such things I think is long gone, so
what I'll likely do is kill the sys_nis_syscall stuff from the
sparc ports.
