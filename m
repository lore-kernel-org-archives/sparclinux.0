From: Roel Kluin <12o3l@tiscali.nl>
Date: Sat, 27 Oct 2007 15:25:51 +0000
Subject: possible typo in arch/sparc64/kernel/time.c
Message-Id: <4723587F.1020301@tiscali.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I already posted something on lkml, but it wasn't picked up

in arch/sparc64/kernel/time.c, line 1073 it reads:

        if (!mregs && !dregs & !bregs)

shouldn this be

        if (!mregs && !dregs && !bregs)

or

        if (!mregs && !(dregs & !bregs))

?
