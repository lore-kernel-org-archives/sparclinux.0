From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sat, 28 Jun 2008 23:22:16 +0000
Subject: LTP results on sparc32
Message-Id: <20080628232216.GA27698@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I ran LTP on 2 sparc32 machines, an SS10 and a SS20.
758 tests were run on both, the same 13 tests failed on both.

Kernel Version:	2.6.26-rc6-mph4	UP
Kernel Source:	git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-2.6.git
Last Commit:	38fef2ebeaee1418f182651d23c6124d8184f62d
LTP Version:	ltp-intermediate-20080619
LTP Command:	runltplite.sh -p

Test failures below, host details after that. Will follow up as time allows.

Regards,
Martin

Testcase                       Result     Reason
--------                       ------     ----------
clone03                        FAIL       Probably a glibc issue
clone06                        FAIL       Probably a glibc issue
getcontext01                   FAIL       Missing from glibc
msgctl09                       FAIL       Kernel issue
recvmsg01                      FAIL       succeeded when it should fail
sendmsg01                      FAIL       succeeded when it should fail
setdomainname02                FAIL       succeeded when it should fail
setgroups04                    FAIL       succeeded when it should fail
sockioctl01                    FAIL       errno, expected 14
sysctl01                       FAIL       Not implemented
sysctl03                       FAIL       Not implemented
sysctl04                       FAIL       Not implemented
sysctl05                       FAIL       Not implemented
-----------------------------------------------
Hostname:	palantir9 (SS20)

Gnu C                  gcc (GCC) 3.4.6 (Debian 3.4.6-5)
Linux C Library        2.3.6 + patch for bug 6471
Dynamic linker (ldd)   2.3.6

cpu             : ROSS HyperSparc RT625 or RT626
type            : sun4m SS20
ncpus probed    : 2
ncpus active    : 1
CPU0Bogo        : 124.51
CPU0ClkTck      : 125000000
-----
Hostname:	palantir13 (SS10)

Gnu C                  gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)
Linux C Library        2.3.6 + patch for bug 6471
Dynamic linker (ldd)   2.3.6

cpu             : Texas Instruments, Inc. - SuperSparc-(II)
type            : sun4m SS10
ncpus probed    : 2
ncpus active    : 1
CPU0Bogo        : 49.76
CPU0ClkTck      : 50000000
