From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 08 Nov 2019 20:34:23 +0000
Subject: [PATCH 0/8] y2038: bug fixes from y2038 work
Message-Id: <20191108203435.112759-1-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Corey Minyard <minyard@acm.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org, openipmi-developer@lists.sourceforge.net, linux-input@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, sparclinux@vger.kernel.org

I've gone through the remaining uses of time_t etc and come up with a
set of 90 patches of varying complexity and importance, to the point
of being able to remove the old time_t/timeval/timespec from the kernel
headers completely.

This set includes the eight patches that I think should be merged
right away and backported into stable kernels if possible.

Please apply individual patches to the respective maintainer trees
for either v5.4 or v5.5 as appropriate.

For reference, the full series of 90 patches can be found at
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=y2038-endgame

      Arnd

Arnd Bergmann (8):
  y2038: timex: remove incorrect time_t truncation
  timekeeping: optimize ns_to_timespec64
  powerpc: fix vdso32 for ppc64le
  ipmi: kill off 'timespec' usage again
  netfilter: xt_time: use time64_t
  lp: fix sparc64 LPSETTIMEOUT ioctl
  ppdev: fix PPGETTIME/PPSETTIME ioctls
  Input: input_event: fix struct padding on sparc64

 arch/powerpc/kernel/vdso32/gettimeofday.S |  2 +-
 drivers/char/ipmi/ipmi_si_intf.c          | 40 ++++++++---------------
 drivers/char/lp.c                         |  4 +++
 drivers/char/ppdev.c                      | 16 ++++++---
 drivers/input/evdev.c                     |  3 ++
 drivers/input/misc/uinput.c               |  3 ++
 include/uapi/linux/input.h                |  1 +
 kernel/time/ntp.c                         |  2 +-
 kernel/time/time.c                        | 21 +++++++-----
 net/netfilter/xt_time.c                   | 19 ++++++-----
 10 files changed, 61 insertions(+), 50 deletions(-)

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Corey Minyard <minyard@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: openipmi-developer@lists.sourceforge.net
Cc: linux-input@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org

-- 
2.20.0
