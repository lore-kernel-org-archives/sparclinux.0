From: ludo@chbouib.org (Ludovic =?iso-8859-1?Q?Court=E8s?=)
Date: Tue, 01 May 2007 18:48:34 +0000
Subject: ICE with GCC 4.1
Message-Id: <87odl4qt19.fsf@chbouib.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Does anyone get the following ICE when compiling the latest kernel (from
David Miller's Git tree) on sparc32:

    CC      kernel/sched.o
  kernel/sched.c: In function 'effective_prio':
  kernel/sched.c:744: internal compiler error: in choose_multiplier, at expmed.c:3304
  Please submit a full bug report,
  with preprocessed source if appropriate.
  See <URL:http://gcc.gnu.org/bugs.html> for instructions.
  For Debian GNU/Linux specific bug reporting instructions,
  see <URL:file:///usr/share/doc/gcc-4.1/README.Bugs>.

The compiler is gcc-4.1 from Debian unstable:

  gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)

Should I be using another version?

Thanks,
Ludovic.

