From: David Miller <davem@davemloft.net>
Date: Fri, 13 Jun 2008 04:15:50 +0000
Subject: [GIT]: Sparc
Message-Id: <20080612.211550.160748198.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this Sparc bug fix, thanks!

The following changes since commit 399dc43bc29fe1ac19340c56c0df84aa0ea53c85:
  Alexey Dobriyan (1):
        sparc: switch /proc/led to seq_file

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Robert Reif (1):
      sparc: get leo framebuffer working

 drivers/video/leo.c |   58 ++++++++++++++++++++++----------------------------
 1 files changed, 26 insertions(+), 32 deletions(-)
