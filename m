From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Wed, 18 Apr 2018 16:29:56 +0000
Subject: [PATCH 0/2] sparc64: Add privileged ADI driver
Message-Id: <20180418162958.442909-1-tom.hromatka@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

ADI is a feature supported on SPARC M7 and newer processors to allow
hardware to catch rogue accesses to memory. ADI is supported for data
fetches only and not instruction fetches. An app can enable ADI on its
data pages, set version tags on them and use versioned addresses to
access the data pages. Upper bits of the address contain the version
tag. On M7 processors, upper four bits (bits 63-60) contain the version
tag. If a rogue app attempts to access ADI enabled data pages, its
access is blocked and processor generates an exception. Please see
Documentation/sparc/adi.txt for further details.

This patchset implements a char driver to read/write ADI versions from
privileged user space processes.  Intended consumers are makedumpfile
and crash.

Tom Hromatka (2):
  char: sparc64: Add privileged ADI driver
  selftests: sparc64: char: Selftest for privileged ADI driver

 drivers/char/Kconfig                               |  12 +
 drivers/char/Makefile                              |   1 +
 drivers/char/adi.c                                 | 262 ++++++++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/sparc64/Makefile           |  52 ++
 tools/testing/selftests/sparc64/drivers/.gitignore |   1 +
 tools/testing/selftests/sparc64/drivers/Makefile   |  13 +
 tools/testing/selftests/sparc64/drivers/adi-test.c | 727 +++++++++++++++++++++
 8 files changed, 1069 insertions(+)
 create mode 100644 drivers/char/adi.c
 create mode 100644 tools/testing/selftests/sparc64/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/.gitignore
 create mode 100644 tools/testing/selftests/sparc64/drivers/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/adi-test.c

-- 
2.15.0

