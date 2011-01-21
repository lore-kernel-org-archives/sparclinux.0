From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Fri, 21 Jan 2011 20:36:30 +0000
Subject: [patch 0/3] Fix alignment of custom sections made from structures (v3)
Message-Id: <20110121203630.725922272@efficios.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, Richard Mortimer <richm@oldelvet.org.uk>, ben@decadent.org.uk, sparclinux@vger.kernel.org

Hello,

Here is a patchset that fixes the Ftrace-induced crash experienced on sparc64
discussed in the following thread: https://lkml.org/lkml/2011/1/16/2

The third patch changes the Tracepoints to use the more compact alignment scheme
proposed here, even though their alignment on 32-byte works fine. This third
patch is therefore not a fix per se.

The patchset is based on 2.6.37. Hopefully there are not too many things to
update for the current -git.

Changelog since v2: drop the "packed" attribute, because it caused unaligned 
acceses on sparc64 by dropping the padding between consecutive "int" and 
"pointer"/"long" fields.

Comments are welcome,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
