From: David Miller <davem@davemloft.net>
Date: Tue, 16 Oct 2012 20:16:17 +0000
Subject: [PATCH 0/3] Sparc64 perf bug fixes and debugging facilities.
Message-Id: <20121016.161617.783317118411774540.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I had to track down a few perf bugs on sparc64, and it's impossible
currently to see what's happening when debugging complicated issues
such as seeing perf stop getting events when monitoring using all cpus
in a huge system.

So one patch here is a new 'x' sysrq that dumps the PMU control
registers on every cpu.

Next we have a bug fix inherited from x86, making sure there is a
valid and alive address space before we go trying to probe the user
stack for a backtrace.

Finally, fix PCR control reg setting in sparc_pmu_enable_event(). This
basically broke 'perf top' and similar things.

Pushed out to 'sparc'.

Signed-off-by: David S. Miller <davem@davemloft.net>
