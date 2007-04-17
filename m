From: Emanuele Rocca <ema@debian.org>
Date: Tue, 17 Apr 2007 12:19:49 +0000
Subject: Re:  [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070417121949.GA31743@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

* David Miller <davem@davemloft.net>, [2007-04-16 15:21 -0700]:
>  But the bottom line is that we must use the output-device to
>  determine the console output framebuffer device in the absense
>  of a console= command line specification.

Maybe I'm just stating something obiouvs, by the way I hope this can
help tracking down the problem. 

set_preferred_console (arch/sparc64/kernel/setup.c) returns -ENODEV
either booting with atyfb enabled or disabled.

output-device is 0 (PROMDEV_OSCREEN).

ciao,
    ema
