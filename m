From: David Miller <davem@davemloft.net>
Date: Sun, 19 Oct 2014 17:32:04 +0000
Subject: Re: [PATCH v2 0/2] SILO: fix build issues with GNU11 mode
Message-Id: <20141019.133204.926260712777174492.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1413719857-9838-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1413719857-9838-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 14:57:35 +0300

> Hi,
> 
> GCC will switch to GNU11 default mode, and currently SILO
> compilation is broken with GCC 4.9.1 and--std=gnu11 due to ext2fs
> inline function declarations.
> 
> These cleanup patches should fix the build, while not making any
> functional changes (same code is generated with current GNU89 default
> mode with and without these patches).
> 
> Tested by running SILO installation + boot with versions compiled
> with both GNU89 & GNU11 modes using GCC 4.9.1 on Ultrasparc.
> 
> v2: Just delete code instead of trying to clean it up.

This is a lot better, applied, thanks.

Feel free to submit a patch which explicitly turns on GNU11 for
the build when the compiler supports it.

That way we'll never break the build in this manner.
