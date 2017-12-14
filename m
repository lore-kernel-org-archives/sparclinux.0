From: David Miller <davem@davemloft.net>
Date: Thu, 14 Dec 2017 16:08:55 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20171214.110855.2120337295444660436.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Thu, 14 Dec 2017 14:59:55 +0000

> Please elaborate as I don't understand what's happening here. Thank
> you.

Well, re-reviewing your patch I do have technical feedback.

You're copying several datastructures and code from the existing MDESC
code.

Please share as much code as possible with arch/sparc/kernel/mdesc.c

Thank you.
