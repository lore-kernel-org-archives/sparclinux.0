From: David Miller <davem@davemloft.net>
Date: Wed, 04 Jun 2008 23:56:21 +0000
Subject: [GIT]: Sparc
Message-Id: <20080604.165621.84201273.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc updates.

Thanks!

The following changes since commit 551dec47bb5964478db594385a896eb0d4ab2b0a:
  Adrian Bunk (1):
        sparc64: global_reg_snapshot is not for userspace

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Alexey Dobriyan (1):
      sparc: switch /proc/led to seq_file

Benjamin Herrenschmidt (1):
      sparc64: IO accessors fix

 arch/sparc/kernel/led.c  |   34 ++++++++++++++---------
 include/asm-sparc64/io.h |   66 ++++++++++++++++++++++++++++++---------------
 2 files changed, 65 insertions(+), 35 deletions(-)
