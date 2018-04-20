From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Fri, 20 Apr 2018 19:39:37 +0000
Subject: [PATCH v3 0/2] sparc64: Add privileged ADI driver
Message-Id: <20180420193939.487546-1-tom.hromatka@oracle.com>
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

v3:
  * Really fixed the copyright headers to use SPDX GPL v2.  Really.
v2:
  * Simplified copyright headers
  * Completely reworked sparc64 selftests Makefiles.  Used the
    android selftests Makefiles as an example
  * Added run.sh and drivers_test.sh to the sparc64 selftest
    directory.  Used bpf/test_kmod.sh and the android selftests
    as examples
  * Minor cleanups in the selftest adi-test.c
  * Added calls to ksft_test_*() in the adi-test.c

Tom Hromatka (2):
  SPARC M7 and newer processors utilize ADI to version and protect
    memory.  This driver is capable of reading/writing ADI/MCD versions
    from privileged user space processes. Addresses in the adi file are
    mapped linearly to physical memory at a ratio of 1:adi_blksz.  Thus,
    a read (or write) of offset K in the file operates upon the ADI
    version at physical address K * adi_blksz.  The version information
    is encoded as one version per byte.  Intended consumers are
    makedumpfile and crash.
  Add a selftest for the sparc64 privileged ADI driver.  These tests
    verify the read(), pread(), write(), pwrite(), and seek()
    functionality of the driver.  The tests also report simple
    performance statistics:

 drivers/char/Kconfig                               |  12 +
 drivers/char/Makefile                              |   1 +
 drivers/char/adi.c                                 | 240 +++++++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/sparc64/Makefile           |  46 ++
 tools/testing/selftests/sparc64/drivers/.gitignore |   1 +
 tools/testing/selftests/sparc64/drivers/Makefile   |  15 +
 tools/testing/selftests/sparc64/drivers/adi-test.c | 721 +++++++++++++++++++++
 .../selftests/sparc64/drivers/drivers_test.sh      |  30 +
 tools/testing/selftests/sparc64/run.sh             |   3 +
 10 files changed, 1070 insertions(+)
 create mode 100644 drivers/char/adi.c
 create mode 100644 tools/testing/selftests/sparc64/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/.gitignore
 create mode 100644 tools/testing/selftests/sparc64/drivers/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/adi-test.c
 create mode 100755 tools/testing/selftests/sparc64/drivers/drivers_test.sh
 create mode 100755 tools/testing/selftests/sparc64/run.sh

-- 
2.15.0

