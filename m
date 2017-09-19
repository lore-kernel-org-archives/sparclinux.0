From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 17:33:26 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.103326.1111451883305925049.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 08:58:06 +0200

> It also shouldn't be necessary to install a special tool to be able
> to parse hardware information. /dev/mdesc sounds like a relict from
> the old Linux days to me which should be superceded by sysfs.

The kernel has no business having all of the details of how to
interpret binary property values, what they mean, what the
most reasonable way is to format them, etc.

That's userspace.

Sparc users already make use of special tools such as 'prtconf'
and 'mdlint' already exists and works just fine.
