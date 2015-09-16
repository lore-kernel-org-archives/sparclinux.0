From: David Miller <davem@davemloft.net>
Date: Wed, 16 Sep 2015 17:57:20 +0000
Subject: Re: [PATCH v2 3/9] sparc/sparc64: allocate sys_membarrier system call number
Message-Id: <20150916.105720.1147038044649285686.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1441642556-30972-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1441642556-30972-4-git-send-email-mathieu.desnoyers@efficios.com>
	<542470980.9287.1442415954054.JavaMail.zimbra@efficios.com>
In-Reply-To: <542470980.9287.1442415954054.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-api@vger.kernel.org, akpm@linux-foundation.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 16 Sep 2015 15:05:54 +0000 (UTC)

> ----- On Sep 7, 2015, at 12:15 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Acked-by: "David S. Miller" <davem@davemloft.net>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: linux-api@vger.kernel.org
>> CC: sparclinux@vger.kernel.org
> 
> Hi,
> 
> FYI, sys_membarrier has been merged upstream in Linux 4.3-rc1. Feel free
> to wire up this system call on sparc.

Since I ACK'd this patch which wires the system call up, it should
have been submitted by you directly.  That's the whole idea.
