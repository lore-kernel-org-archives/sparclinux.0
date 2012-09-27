From: Bob Picco <bpicco@meloft.net>
Date: Thu, 27 Sep 2012 15:36:43 +0000
Subject: [PATCH 0/2] sparc 64 bit sigaltstack issue
Message-Id: <1348760205-26101-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

Hi:

On Debian building a 64 bit elf a.out which expects a signal delivered
on an alternate stack fails with a segfault. The second patch repairs
the issue. The first patch is a minor whitespace removal.

thanx,

bob

bob picco (2):
  sparc do_rt_sigreturn - minor clean up
  do_rt_sigreturn provide the target sp

 arch/sparc/kernel/signal_64.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.10

