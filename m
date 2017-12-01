From: David Miller <davem@davemloft.net>
Date: Fri, 01 Dec 2017 19:46:25 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20171201.144625.11763577390736377.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Fri, 1 Dec 2017 17:15:13 +0000

> Do you have any concern with this patch?

I'm just wondering if the blacklist of sensitive nodes is complete and
also futureproof.

That's my first concern.

Also the hypervisor specification URL is completely non-functional,
the kenai.com stuff went down years ago.

It's pretty rediculous for me to include code written to a
specification nobody can access and check against the implementation.
