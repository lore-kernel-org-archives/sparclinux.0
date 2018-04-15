From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 15 Apr 2018 15:59:09 +0000
Subject: [RFC PATCH 3/3] signal: Stop special casing TRAP_FIXME and FPE_FIXME in siginfo_layout
Message-Id: <87muy48nqq.fsf_-_@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
        <20180412172051.GK16141@n2100.armlinux.org.uk>
        <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
        <20180413094211.GN16141@n2100.armlinux.org.uk>
        <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
        <20180413170827.GB16308@e103592.cambridge.arm.com>
        <20180413175407.GO16141@n2100.armlinux.org.uk>
        <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
        <20180413184522.GD16308@e103592.cambridge.arm.com>
        <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
        <20180415131206.GR16141@n2100.armlinux.org.uk>
        <87604sa2fu.fsf_-_@xmission.com>
In-Reply-To: <87604sa2fu.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Sun, 15 Apr 2018 10:56:21 -0500")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, sparclinux <sparclinux@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arch@vger.kernel.org


After more experience with the cases where no one the si_code of 0 is
used both as a signal specific si_code, and as SI_USER it appears that
no one cares about the signal specific si_code case and the good
solution is to just fix the architectures by using a different si_code.

In none of the conversations has anyone even suggested that anything
depends on the signal specific redefinition of SI_USER.

There are at least test cases that care when si_code as 0 does not work
as si_user.

So make things simple and keep the generic code from introducing
problems by removing the special casing of TRAP_FIXME and FPE_FIXME.
This will ensure the generic case of sending a signal with kill will
always set SI_USER and work.

The architecture specific, and signal specific overloads that set
si_code to 0 will now have problems with signalfd and the 32bit compat
versions of siginfo copying.  At least until they are fixed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d56f4d496c89..fc82d2c0918f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2835,15 +2835,6 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 			layout = SIL_POLL;
 		else if (si_code < 0)
 			layout = SIL_RT;
-		/* Tests to support buggy kernel ABIs */
-#ifdef TRAP_FIXME
-		if ((sig = SIGTRAP) && (si_code = TRAP_FIXME))
-			layout = SIL_FAULT;
-#endif
-#ifdef FPE_FIXME
-		if ((sig = SIGFPE) && (si_code = FPE_FIXME))
-			layout = SIL_FAULT;
-#endif
 	}
 	return layout;
 }
-- 
2.14.1

