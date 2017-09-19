From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 18:04:24 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.110424.1419250176281651461.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 19 Sep 2017 18:55:52 +0300

> please, lets not make/introduce another tool for parsing /dev/mdesc,
> it's so easier to use sysfs , instead of using another arch-specific
> (sparc64) tool, like prtconf.

We have /dev/mdesc already, and there is an existing tool, mdlint.

I use it every day.

I'm not suggesting to use anything new, I'm saying use the stuff
that we have already.

