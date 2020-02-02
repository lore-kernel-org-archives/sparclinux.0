From: David Miller <davem@davemloft.net>
Date: Sun, 02 Feb 2020 10:57:57 +0000
Subject: [GIT] Sparc
Message-Id: <20200202.115757.1806399388803712136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this adjtimex regression fix from Arnd.

Thank you!

The following changes since commit 94f2630b18975bb56eee5d1a36371db967643479:

  Merge tag '5.6-rc-small-smb3-fix-for-stable' of git://git.samba.org/sfrench/cifs-2.6 (2020-02-01 11:22:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 11648b8339f840d4b1f4c54a1abec8025d9e077d:

  sparc64: fix adjtimex regression (2020-02-02 11:54:41 +0100)

----------------------------------------------------------------
Arnd Bergmann (1):
      sparc64: fix adjtimex regression

 arch/sparc/kernel/sys_sparc_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
