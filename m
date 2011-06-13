From: Meelis Roos <mroos@linux.ee>
Date: Mon, 13 Jun 2011 17:28:05 +0000
Subject: Re: RTC problem on Netra X1?
Message-Id: <alpine.SOC.1.00.1106132011540.20957@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Dmesg finds both OF RTC and PC RTC but later complains
> > "No RTC device found, ALARM timers will not wake from suspend"

Bisected this too - first on driver/rtc arch/sparc, the result seemed 
suspicious, redid with last good and bad commit with whole tree. Got
32673822e440eb92eb334631eb0a199d0c532d13 to be the first bad commit.
This is about jump labels - seemingly unrelated but touches several 
architectures, sparc included. It can not be easily reverted on master 
for testing either.

Another data point: If I applied the other revert for hwclock RTC 
problem on top of 3.0rc2, it also cured this problem.

Whole git bisect log if it is of any interest. Started from
git bisect start '32673822e440eb92eb334631eb0a199d0c532d13' 'f400bdb1d6de4344980cf39041497b288090dd33'
as these were the last bad and good commits from bisecting just 
drivers/rtc and arch/sparc.

# bad: [32673822e440eb92eb334631eb0a199d0c532d13] Merge branch 'tip/perf/core' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace into perf/core
# good: [f400bdb1d6de4344980cf39041497b288090dd33] sparc32: fix build, fix missing cpu_relax declaration
git bisect start '32673822e440eb92eb334631eb0a199d0c532d13' 'f400bdb1d6de4344980cf39041497b288090dd33'
# good: [2f666bcf757cb72549f360ef6da02f03620a48b6] Merge branch 'drm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6
git bisect good 2f666bcf757cb72549f360ef6da02f03620a48b6
# good: [25b210371f76ac63b30d998549f5f4891d805f3b] Merge branch 'drm-intel-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/keithp/linux-2.6
git bisect good 25b210371f76ac63b30d998549f5f4891d805f3b
# good: [91e8549bde9e5cc88c5a2e8c8114389279e240b5] Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-block
git bisect good 91e8549bde9e5cc88c5a2e8c8114389279e240b5
# good: [f18568aae5612ab37f20e5f383d6154ea69c9dfc] perf tools: git mv tools/perf/{features-tests.mak,config/}
git bisect good f18568aae5612ab37f20e5f383d6154ea69c9dfc
# good: [5373db886b791b2bc7811e2c115377916c409a5d] jump label: Add s390 support
git bisect good 5373db886b791b2bc7811e2c115377916c409a5d
# good: [eff430de53be6f3328c3eebe93755f1ecf499e37] Merge branch 'linus' into perf/core
git bisect good eff430de53be6f3328c3eebe93755f1ecf499e37
# good: [fa7b69475a6c192853949ba496dd9c37b497b548] perf events, x86, P4: Fix typo in comment
git bisect good fa7b69475a6c192853949ba496dd9c37b497b548

Any ideas what to look next?

-- 
Meelis Roos (mroos@linux.ee)
