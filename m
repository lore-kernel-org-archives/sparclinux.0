From: David Miller <davem@davemloft.net>
Date: Sat, 29 Nov 2008 06:08:30 +0000
Subject: [PATCH 0/2]: Niagara pseudo-NMI profiling support
Message-Id: <20081128.220830.223889354.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This turned out to be a little bit trickier than I anticipated.

The biggest stumbling block is that Niagara-1 only provides the
INSN cycle counter as a fixed selection in the upper PIC
performance counter.

So, to make things simpler, I made all of the implementations
measure the event in the upper PIC.
