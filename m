From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 18:14:37 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.111437.2031816050248355517.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 20:08:40 +0200

> Does it work without root privileges?

Depends upon what permissions and ownership the administrator decides
to set for /dev/mdesc

Which is identical to what you would get with sysfs, "file permissions"

This conversation is going nowhere, can you guys please drop this?

We're not exporting the machine desctription in a second way, period.
