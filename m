From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 30 Jul 2015 14:04:54 +0000
Subject: Debian drops support for sparc
Message-Id: <20150730140453.GA25014@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all.

Debian have decided to drop support for sparc.
See additional details  here: https://lists.debian.org/debian-sparc/2015/07/msg00023.html

To the best of my understanding this is 32 bit userland
on top of sparc64 kernel that is dropped.

In Debian ports there is a sparc64 port which is 64-bit
userland on top of sparc64 kernel.
There are talks about improving support for the sparc64
ports but I have not read anything conclusive.

Additional details can be found the following bug report:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bugt5938

A major issue is that gcc-4.9 cannot be built for sparc
for reasons that I failed to follow.

When I read: https://bugs.debian.org/cgi-bin/bugreport.cgi?bugt5938#48
I get the impression that this is for the most part
bugs that may have been fixed recently.
The regression testing doen by Meelis Roos has shown
that things has improved a lot the last couple of months
if I recall correct. So sad that Debian drops sparc support now
when these fixes may not have propagated.

In a G+ post I also referred to the memcpy / FPU register
corruption bug that David only recently were able to reproduce.
I am not sure how much this bug influence the lack of stability
that people see when using sparc64 kernels.
See details here: http://marc.info/?t3382318800002&r=1&w=2

	Sam
