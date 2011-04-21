From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 18:09:23 +0000
Subject: Re: [PATCH 0/7] sparc32,leon: additional genirq patches
Message-Id: <20110421.110923.241432698.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DADB2F4.6070402@gaisler.com>
In-Reply-To: <4DADB2F4.6070402@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 14:58:53 +0200

> The issue with boot_cpu_id being cleared is btw not new - but
> I should have caught that anyway.

It's partially another side effect of that awful behavioral change GCC
made several years ago to "auto BSS" variables explicitly initialized
to zero.

You used to be able to add an explicit zero initialization to force
items into the data section.

This change has broken various things in the sparc32 port over the
years.

Probably the thing to do is to initialize boot_cpu_id{,4} to some
"invalid" value (like 0xff) in the kernel image and just make certain
the the initialization happens early enough.
