From: David Miller <davem@davemloft.net>
Date: Fri, 16 Jan 2009 00:02:59 +0000
Subject: [GIT]: Sparc
Message-Id: <20090115.160259.246293979.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this build fix for Sparc.

Thanks!

The following changes since commit 37a76bd4f1b716949fc38a6842e89f0ccb8384d0:
  Arjan van de Ven (1):
        async: fix __lowest_in_progress()

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Fix UP build failure.

 arch/sparc/kernel/sparc_ksyms_64.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)
