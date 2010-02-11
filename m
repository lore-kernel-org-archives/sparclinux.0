From: David Miller <davem@davemloft.net>
Date: Thu, 11 Feb 2010 20:45:19 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20100211.124519.19952041.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100210.100447.183398767.davem@davemloft.net>
In-Reply-To: <20100210.100447.183398767.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 10 Feb 2010 10:04:47 -0800 (PST)

> 
> Please pull to get this user stack alignment bug fix.
> 
> Thanks!
> 
> The following changes since commit be8cde8b24c9dca1e54598690115eee5b1476519:
>   Linus Torvalds (1):
>         Merge git://git.kernel.org/.../jejb/scsi-rc-fixes-2.6
> 
> are available in the git repository at:
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Linus, if you've pulled please pull again since I just had to fix a thinko
in this change.

Thanks!

The following changes since commit be8cde8b24c9dca1e54598690115eee5b1476519:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../jejb/scsi-rc-fixes-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc: Align clone and signal stacks to 16 bytes.
      sparc32: Fix thinko in previous change.

 arch/sparc/kernel/process_32.c |    2 +-
 arch/sparc/kernel/process_64.c |    8 ++++----
 arch/sparc/kernel/signal32.c   |   10 ++++++----
 arch/sparc/kernel/signal_32.c  |    6 ++++--
 arch/sparc/kernel/signal_64.c  |    8 +++++---
 5 files changed, 20 insertions(+), 14 deletions(-)
