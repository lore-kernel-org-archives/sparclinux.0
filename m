From: Tim Abbott <tabbott@ksplice.com>
Date: Wed, 16 Sep 2009 16:46:31 +0000
Subject: [PATCH v2] Linker script cleanup for sparc
Message-Id: <1253119592-19598-1-git-send-email-tabbott@ksplice.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Tim Abbott <tabbott@ksplice.com>

This is an updated version of the patch series I sent in late July
cleaning up the sparc architecture's linker scripts.  The only change is
that it is rebased on top of Linus's current master.

This cross-architecture linker script cleanup project is in
preparation for adding support for building the kernel with
-ffunction-sections -fdata-sections, which is a prerequisite for
Ksplice.

	-Tim Abbott

Geoffrey Thomas (1):
  sparc: Clean up linker script using new linker script macros.

 arch/sparc/kernel/vmlinux.lds.S |   75 ++++-----------------------------------
 1 files changed, 7 insertions(+), 68 deletions(-)

