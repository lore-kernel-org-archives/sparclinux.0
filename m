From: carbonated beverage <ramune@net-ronin.org>
Date: Thu, 20 May 2004 06:41:42 +0000
Subject: unkillable process in R state, 2.6.6
Message-Id: <20040520064141.GA30223@net-ronin.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Noticed any site I go through my proxy chain was not reachable, and poked
about.  squid sits in the 'R' state forever, and I can't shut it down with
kill -KILL | -STOP | -ILL | -FPU | -SEGV

The first site I go to through it works fine.  I can browse pages off it
and follow links within that domain.  When I go to another site through
squid, it hits the 'R' state and sits there forever.  I can't even attach
with gdb/strace to find out what code it's looping on.

It's the binary out of debian/testing for sparc, using a bk pull of 2.6.6.

Anyone have ideas how I can go about debugging this to see what's going on?

It's an Ultra 5 (Ultra IIi/333MHz), gcc 3.3.3, binutils 2.14.90.0.7,
make 3.80, following possibly relevant flags set:
CONFIG_IOSCHED_AS=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_PREEMPT=y

Previous kernel, 2.6.5 from a bk pull, worked fine.

-- DN
Daniel
