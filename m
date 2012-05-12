From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 11:42:45 +0000
Subject: [PATCH 0/4] sparc32: addtional cleanup in haed_32.S
Message-Id: <20120512114245.GA8192@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

This cleans up the cputype as you suggested.
While reading the code I found several other
small items that could be simplified.

Boot-tested on both UP and SMP on my ss5.

The cleanup the last two days have done wonders to the readability
of head_32.S :-)

	Sam


 arch/sparc/kernel/head_32.S |  108 ++++++++-----------------------------------
 1 files changed, 19 insertions(+), 89 deletions(-)

Sam Ravnborg (4):
      sparc32: remove sun4c specific variables from head_32.S
      sparc32: drop prom version check in head_32.S
      sparc32: drop extra getprop call during boot
      sparc32: simpler cputype check in head_32.S

