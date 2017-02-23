From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:23:21 +0000
Subject: Re: [PATCH] sparc64: fix for user probes in high memory
Message-Id: <20170223.112321.2007607301587258311.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4e296aa1-f5b2-3d50-ae08-1a9f9cc70a45@oracle.com>
In-Reply-To: <4e296aa1-f5b2-3d50-ae08-1a9f9cc70a45@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Mon, 6 Feb 2017 14:32:41 +0000

> When returning from the user probe code into userspace process, PC &
> NPC are
> truncated to 32 bits.
> 
> Due to shared libraries getting loaded very high in the virtual
> address space of
> the process, placing a user probe inside a shared library makes the
> kernel
> return into the process at the wrong address, causing it to seg'fault
> most of
> the time.
> 
> This patch prevents truncating PC and NPC.
> 
> Signed-off-by: Eric Saint Etienne <eric.saint.etienne@oracle.com>
> Reviewed-by: David Aldridge <david.j.aldridge@oracle.com>

Applied.
