From: Robert Reif <reif@earthlink.net>
Date: Fri, 09 Jan 2009 00:32:21 +0000
Subject: sparc32 broke
Message-Id: <49669B15.7020107@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

A compile of todays mainline produces this compile error:

arch/sparc/kernel/sun4d_smp.c:63: error: expected identifier or =91(=92=20
before =91{=92 token
arch/sparc/kernel/sun4d_smp.c: In function =91smp4d_callin=92:
arch/sparc/kernel/sun4d_smp.c:118: error: lvalue required as left=20
operand of assignment
arch/sparc/kernel/sun4d_smp.c:118: error: lvalue required as left=20
operand of assignment

Prior to today, sparc32 has also failed to boot completely for the last=20
few days.
It boots but fails in the init scripts when it can't find the boot=20
partition.

Ill try to bisect the boot problem but it will take a while.


