From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 18 Aug 2016 15:46:05 +0000
Subject: Re: [PATCH v8 0/4] improvements to the nmi_backtrace code
Message-Id: <cae871a8-8d21-2cc0-6fed-0aed6b1159fa@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
In-Reply-To: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Metcalf <cmetcalf@mellanox.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 16/08/16 20:50, Chris Metcalf wrote:
> This is a rebase of the series onto v4.8-rc2, plus some changes from
> various reviewers.
>
> From the version 1 cover letter:
>
>   This patch series modifies the trigger_xxx_backtrace() NMI-based
>   remote backtracing code to make it more flexible, and makes a few
>   small improvements along the way.
>
>   The motivation comes from the task isolation code, where there are
>   scenarios where we want to be able to diagnose a case where some cpu
>   is about to interrupt a task-isolated cpu.  It can be helpful to
>   see both where the interrupting cpu is, and also an approximation
>   of where the cpu that is being interrupted is.  The nmi_backtrace
>   framework allows us to discover the stack of the interrupted cpu.
>
> I've tested that the change works as desired on tile, and build-tested
> x86, arm, mips, and sparc64.  For x86 I confirmed that the generic
> cpuidle stuff as well as the architecture-specific routines are in the
> new cpuidle section.  For arm, mips, and sparc I just build-tested it
> and made sure the generic cpuidle routines were in the new cpuidle
> section, but I didn't attempt to figure out which the
> platform-specific idle routines might be.  That might be more usefully
> done by someone with platform experience in follow-up patches.

You can add runtime testing on arm to the list (I didn't try to exploit 
the new one-line-for-idle feature but there were no regressions). All 
patches:

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
