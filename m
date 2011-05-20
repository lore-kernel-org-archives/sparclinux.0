From: David Miller <davem@davemloft.net>
Date: Fri, 20 May 2011 20:13:01 +0000
Subject: Re: [PATCH 1/2] Fix merge problem between sparc32 IPI patches and
Message-Id: <20110520.161301.913577691507123777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1305900070-23492-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1305900070-23492-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: daniel@gaisler.com
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, peterz@infradead.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 20 May 2011 16:01:09 +0200

> Fixes a merge conflict in arch/sparc/kernel/smp_32.c between commit
> d6d048192b1d ("sparc32: implement SMP IPIs using the generic functions")
> from the sparc tree and commit 184748cc50b2 ("sched: Provide
> scheduler_ipi() callback in response to smp_send_reschedule()").
> 
> The patch adds a call to scheduler_ipi() from the resched IPI handler in
> sparc32.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

What I did to handle this was merge in enough of the upstream commit
by Peter such that both of these patches apply, via:

git merge --no-commit 317f394160e9beb97d19a84c39b7e5eb3d7815a8

then I added patch #1 into the merge commit.

Next, I applied patch #2 afterwards.

So we should be all set when I push this out to Linus, thanks!
