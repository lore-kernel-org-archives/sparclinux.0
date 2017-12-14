From: David Miller <davem@davemloft.net>
Date: Thu, 14 Dec 2017 13:44:48 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20171214.084448.470051205068713664.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Thu, 14 Dec 2017 11:01:58 +0000

> That said this sanitization task should be on top of your sparc todo
> list IMHO because the existing /dev/mdesc driver doesn't filter
> anything as of today, so it leaks critical/sensitive data to the OS.

It's root only.
