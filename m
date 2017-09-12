From: David Miller <davem@davemloft.net>
Date: Tue, 12 Sep 2017 04:17:58 +0000
Subject: Re: [PATCH] sparc64: Oracle DAX infrastructure
Message-Id: <20170911.211758.1517905965195679065.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 11 Sep 2017 17:28:19 -0600

> The stubs/templates/constants reflect the hypervisor APIs, so there is
> not very much flexibility in how these are done.

There is no reason to add hypervisor calls to the kernel until there is
also a user.

We always have a requirement to sequence a new interface in the kernel
with and actual user of that interface.
