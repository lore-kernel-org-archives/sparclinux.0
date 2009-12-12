From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:18 +0000
Subject: [PATCH 0/10]: Filling feature holes and bug fixes
Message-Id: <20091211.225518.193687539.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I went through all of the changes that went into the merge
window so far (primarily x86, powerpc, tracing, kprobes,
perf) to see if there were any holes to fill in for sparc.

The 10 patches following this posting are the result and are
all in sparc-2.6 tree and will be sent to Linus.

The only real gap left is finishing the dependency engine
necessary to support more than 1 performance counter at a
time on sparc64.  I hope to get back to that soon.
