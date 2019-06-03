From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jun 2019 05:21:07 +0000
Subject: [GIT] Sparc
Message-Id: <20190602.222107.923223011133534329.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these three bug fixes, and TLB flushing one is of
particular brown paper bag quality...

Thanks.

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 56cd0aefa475079e9613085b14a0f05037518fed:

  sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD (2019-06-02 22:16:33 -0700)

----------------------------------------------------------------
Gen Zhang (1):
      mdesc: fix a missing-check bug in get_vdev_port_node_info()

James Clarke (1):
      sparc64: Fix regression in non-hypervisor TLB flush xcall

Young Xiao (1):
      sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD

 arch/sparc/kernel/mdesc.c      | 2 ++
 arch/sparc/kernel/perf_event.c | 4 ++++
 arch/sparc/mm/ultra.S          | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)
