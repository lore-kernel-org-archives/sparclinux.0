From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 22:36:00 +0000
Subject: Fix warnings in exported headers
Message-Id: <20090101223600.GA19647@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

kbuild has recently starting to be noisy of certian patterns
of bad habit in our exported headers - mostly thanks
to Mike Frysinger.

So I ran the latest kbuild tree I had on the sparc headers
and there were a few things to look after.

I divided it up into one patch/header file.
The fixes in jsflash and byteorder are straightforward.

For traps.h I did a bit of googling and as a result I concluded
that there were more than the warned thing that should be
excluded from userspace.

I excluded:
struct tt_entry - it is sparc32 specific and kernel internal
extern struct tt_entry *sparc_ttable; - kernel internal
static inline unsigned long get_tbr(void) - kernel internal

In next patch I delete get_tbr() as it turned out there is no users of it.

	Sam

Sam Ravnborg (3):
      sparc: fix warning in userspace header jsflash.h
      sparc: fix warnings in userspace header byteorder.h
      sparc: fix warning in userspace header traps.h
      sparc: drop get_tbr() in traps.h

 arch/sparc/include/asm/byteorder.h |   12 +++++-------
 arch/sparc/include/asm/jsflash.h   |    2 +-
 arch/sparc/include/asm/traps.h     |   11 ++---------
 3 files changed, 8 insertions(+), 17 deletions(-)

