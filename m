From: David Miller <davem@davemloft.net>
Date: Tue, 05 Jun 2018 18:30:20 +0000
Subject: Re: [PATCH] sparc: fix compat siginfo ABI regression
Message-Id: <20180605.143020.1625862113780952081.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180413141901.GA15253@altlinux.org>
In-Reply-To: <20180413141901.GA15253@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ldv@altlinux.org
Cc: ebiederm@xmission.com, matorola@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Fri, 13 Apr 2018 17:19:02 +0300

> Starting with commit v4.14-rc1~60^2^2~1, a SIGFPE signal sent via kill
> results to wrong values in si_pid and si_uid fields of compat siginfo_t.
> 
> This happens due to FPE_FIXME being defined to 0 for sparc, and at the
> same time siginfo_layout() introduced by the same commit returns
> SIL_FAULT for SIGFPE if si_code = SI_USER and FPE_FIXME is defined to 0.
> 
> Fix this regression by removing FPE_FIXME macro and changing all its users
> to assign FPE_FLTUNK to si_code instead of FPE_FIXME.
> 
> Note that FPE_FLTUNK is a new macro introduced by commit
> 266da65e9156d93e1126e185259a4aae68188d0e.
> 
> Tested with commit v4.16-11958-g16e205cf42da.
> 
> This bug was found by strace test suite.
> 
> Link: https://github.com/strace/strace/issues/21
> Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
> Thanks-to: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Applied and queued up for -stable, thank you.
