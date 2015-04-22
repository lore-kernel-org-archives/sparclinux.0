From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2015 20:04:16 +0000
Subject: Re: [PATCH v4] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <20150422.160416.102939796219378673.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5537cc2f.DHI1MB7QmyJtY/mK%chris.hyser@oracle.com>
In-Reply-To: <5537cc2f.DHI1MB7QmyJtY/mK%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chris.hyser@oracle.com
Date: Wed, 22 Apr 2015 12:28:31 -0400

> commit 5f4826a362405748bbf73957027b77993e61e1af
> Author: chris hyser <chris.hyser@oracle.com>
> Date:   Tue Apr 21 10:31:38 2015 -0400
> 
>     sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
>     
>     The current sparc kernel has no representation for sockets though tools
>     like lscpu can pull this from sysfs. This patch walks the machine
>     description cache and socket hierarchy and marks sockets as well as cores
>     and threads such that a representative sysfs is created by
>     drivers/base/topology.c.
 ...
>     Most of this patch was done by Chris with updates by David.
>     
>     Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
>     Signed-off-by: David Ahern <david.ahern@oracle.com>

Looks good, applied.

On my T4-2, before:

Architecture:          sparc64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Big Endian
CPU(s):                128
On-line CPU(s) list:   0-127
Thread(s) per core:    8
Core(s) per socket:    1
Socket(s):             16
NUMA node(s):          2
NUMA node0 CPU(s):     0-63
NUMA node1 CPU(s):     64-127

and after:

Architecture:          sparc64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Big Endian
CPU(s):                128
On-line CPU(s) list:   0-127
Thread(s) per core:    8
Core(s) per socket:    8
Socket(s):             2
NUMA node(s):          2
NUMA node0 CPU(s):     0-63
NUMA node1 CPU(s):     64-127

Thanks!
