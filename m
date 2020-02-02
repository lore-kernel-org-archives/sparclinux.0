From: David Miller <davem@davemloft.net>
Date: Sun, 02 Feb 2020 10:55:14 +0000
Subject: Re: [PATCH] sparc64: fix adjtimex regression
Message-Id: <20200202.115514.196916055025174984.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200201212104.575657-1-arnd@arndb.de>
In-Reply-To: <20200201212104.575657-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de
Cc: akpm@linux-foundation.org, matorola@gmail.com, ebiederm@xmission.com, deepa.kernel@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Sat,  1 Feb 2020 22:20:52 +0100

> Anatoly Pugachev reported one of the y2038 patches to introduce
> a fatal bug from a stupid typo:
> 
> [   96.384129] watchdog: BUG: soft lockup - CPU#8 stuck for 22s!
> ...
> [   96.385624]  [0000000000652ca4] handle_mm_fault+0x84/0x320
> [   96.385668]  [0000000000b6f2bc] do_sparc64_fault+0x43c/0x820
> [   96.385720]  [0000000000407754] sparc64_realfault_common+0x10/0x20
> [   96.385769]  [000000000042fa28] __do_sys_sparc_clock_adjtime+0x28/0x80
> [   96.385819]  [00000000004307f0] sys_sparc_clock_adjtime+0x10/0x20
> [   96.385866]  [0000000000406294] linux_sparc_syscall+0x34/0x44
> 
> Fix the code to dereference the correct pointer again.
> 
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Tested-by: Anatoly Pugachev <matorola@gmail.com>
> Fixes: 251ec1c159e4 ("y2038: sparc: remove use of struct timex")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The bug was introduced through my y2038 branch and is now in
> mainline, but not in v5.5. Who should pick up the fix to
> get it into v5.6-rc1?

I'll pick it up.

Applied, thanks.
