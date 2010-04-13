From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 13 Apr 2010 19:18:50 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413191847.GA5821@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Apr 12, 2010 at 11:43:00PM -0700, David Miller wrote:
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/Kconfig              |    2 +
>  arch/sparc/kernel/Makefile      |    1 +
>  arch/sparc/kernel/ftrace.c      |   58 ++++++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/irq_64.c      |    3 +-
>  arch/sparc/kernel/kgdb_64.c     |    3 +-
>  arch/sparc/kernel/pcr.c         |    3 +-
>  arch/sparc/kernel/smp_64.c      |   11 ++++---
>  arch/sparc/kernel/time_64.c     |    3 +-
>  arch/sparc/kernel/vmlinux.lds.S |    1 +
>  arch/sparc/lib/mcount.S         |   62 +++++++++++++++++++++++++++++++++++----
>  10 files changed, 132 insertions(+), 15 deletions(-)



Works very well :)

 63)               |  do_sparc64_fault() {
 63)   6.153 us    |    down_read_trylock();
 63)   5.164 us    |    find_vma();
 63)               |    handle_mm_fault() {
 63)   2.966 us    |      add_preempt_count();
 63)   2.856 us    |      sub_preempt_count();
 63)               |      _raw_spin_lock() {
 63)   2.857 us    |        add_preempt_count();
 63)   3.076 us    |        add_preempt_count();
 63)   2.527 us    |        sub_preempt_count();
 63) + 23.513 us   |      }


I planned to add this support but got distracted by the
function tracer problems. And more importantly I'm not yet
enough familiar with sparc.

Thanks!

