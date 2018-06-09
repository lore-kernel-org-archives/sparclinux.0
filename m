From: David Miller <davem@davemloft.net>
Date: Sat, 09 Jun 2018 14:21:14 +0000
Subject: [GIT] Sparc
Message-Id: <20180609.102114.1940060150406660652.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


There is a merge conflict here, just take the "HEAD" hunks and it
will all work out.  It's because I applied a signal code fix that
was already merged and then other cleanups/changes happend on top.

Other than that, this adds the privileged ADI driver from Tom
Hromatka.

Please pull, thanks a lot!

The following changes since commit fff75eb2a08c2ac96404a2d79685668f3cf5a7a3:

  Merge tag 'errseq-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux (2018-04-30 16:53:40 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 1c1ff29da6c86864e73b05d4301a2df1d161f2da:

  sparc: fix compat siginfo ABI regression (2018-06-05 11:29:42 -0700)

----------------------------------------------------------------
David S. Miller (1):
      Merge branch 'adi-driver'

Dmitry V. Levin (1):
      sparc: fix compat siginfo ABI regression

Tom Hromatka (2):
      char: sparc64: Add privileged ADI driver
      selftests: sparc64: char: Selftest for privileged ADI driver

 arch/sparc/include/uapi/asm/siginfo.h                   |   7 -
 arch/sparc/kernel/traps_32.c                            |   2 +-
 arch/sparc/kernel/traps_64.c                            |   2 +-
 drivers/char/Kconfig                                    |  12 ++
 drivers/char/Makefile                                   |   1 +
 drivers/char/adi.c                                      | 239 +++++++++++++++++++++++++++
 tools/testing/selftests/Makefile                        |   1 +
 tools/testing/selftests/sparc64/Makefile                |  46 ++++++
 tools/testing/selftests/sparc64/drivers/.gitignore      |   1 +
 tools/testing/selftests/sparc64/drivers/Makefile        |  15 ++
 tools/testing/selftests/sparc64/drivers/adi-test.c      | 721 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/sparc64/drivers/drivers_test.sh |  30 ++++
 tools/testing/selftests/sparc64/run.sh                  |   3 +
 13 files changed, 1071 insertions(+), 9 deletions(-)
 create mode 100644 drivers/char/adi.c
 create mode 100644 tools/testing/selftests/sparc64/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/.gitignore
 create mode 100644 tools/testing/selftests/sparc64/drivers/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/adi-test.c
 create mode 100755 tools/testing/selftests/sparc64/drivers/drivers_test.sh
 create mode 100755 tools/testing/selftests/sparc64/run.sh
