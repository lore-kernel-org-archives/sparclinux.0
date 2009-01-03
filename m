From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 Jan 2009 12:33:41 +0000
Subject: Export reg.h to userspace
Message-Id: <20090103123341.GB18259@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David et al.

I raised this question in another mail - but as it
may have been overlooked I raise it again.

There is no users of arch/sparc/include/asm/reg.h
and the _32, _64 variants.
Do we really have to export this file to userspace
from the kernel?

I did a grep over the whole kernel and there were
two drivers that used <asm/reg.h> but these were both
powerpc specific drivers and cannot be configured
for a sparc system.

I also checked and only some architectures do provide
a reg.h file - not all of them. So it is not like it is
a mandatory file per see.

I did not check glibc/gdb if they use ths file - I did
not feel brave enough to dive into these as it is new
territory for me.

I could unify tham anyway but they are so different
that I had to have two separate chunks for sparc and
sparc64 anyway and thats not nice.

	Sam

