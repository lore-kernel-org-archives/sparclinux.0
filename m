From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Feb 2011 00:17:09 +0000
Subject: Re: [RFC] sparc32 genirq support v2
Message-Id: <20110220001709.GA8968@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110219154456.GA6908@merkur.ravnborg.org>
In-Reply-To: <20110219154456.GA6908@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all.

[Sorry for breaking the thread - my ISP does not like me]

In the intro mail I had attached the wrong diffstat.
I had switched the arguments to git diff - which explains why
it had more lines added than deleted.
I was in a hurry when I sent the original mail, which is my bad excuse.

The correct diffstat is below - which looks much better.

I also realized that I forgot to cc: Thomas on the actual pacthes.
Will do so in v3.

	Sam


 arch/sparc/Kconfig                 |    5 +-
 arch/sparc/include/asm/floppy_32.h |   41 ++-
 arch/sparc/include/asm/irq_32.h    |    8 +-
 arch/sparc/include/asm/system_32.h |    5 -
 arch/sparc/kernel/Makefile         |    4 -
 arch/sparc/kernel/irq.h            |   86 ++++--
 arch/sparc/kernel/irq_32.c         |  509 ++++++++------------------------
 arch/sparc/kernel/kernel.h         |    7 +-
 arch/sparc/kernel/leon_kernel.c    |    2 +-
 arch/sparc/kernel/of_device_32.c   |   59 +----
 arch/sparc/kernel/pcic.c           |   42 ---
 arch/sparc/kernel/sun4c_irq.c      |  146 ++++++----
 arch/sparc/kernel/sun4d_irq.c      |  575 +++++++++++++++---------------------
 arch/sparc/kernel/sun4m_irq.c      |  204 +++++++-------
 arch/sparc/kernel/sun4m_smp.c      |   16 +-
 arch/sparc/kernel/time_32.c        |    2 +-
 16 files changed, 665 insertions(+), 1046 deletions(-)
