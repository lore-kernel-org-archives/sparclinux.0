From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 15 Feb 2004 10:04:05 +0000
Subject: 2.4 & Solaris work SMP, 2.6 gets RED_state in prom_startcpu()
Message-Id: <20040215100405.GA631@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The RED_state exception goes away when the SMP trampoline is stubbed
out (just before flushw) with a nop loop, so this pretty much narrows
it down to an exception taken on secondary of some kind before the
trampoline code is prepared to recover from it (TLB miss?). The thing
appears to deadlock when the secondaries spin like that, but it doesn't
go down in flames.

Reminder of working things matrix for the box I'm futzing with:

Solaris SMP
2.4 UP and SMP with native builds, UP only with crossbuilds
2.6 UP with native builds only, forgot if 2.6 UP with crossbuilds works

Ultra2, 2x296MHz, 256MB RAM


-- wli
