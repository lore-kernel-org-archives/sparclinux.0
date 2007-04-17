From: Emanuele Rocca <ema@debian.org>
Date: Tue, 17 Apr 2007 19:54:46 +0000
Subject: Re:   [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070417195446.GA32314@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

* Emanuele Rocca <ema@debian.org>, [2007-04-17 14:19 +0200]:
>  set_preferred_console (arch/sparc64/kernel/setup.c) returns -ENODEV
>  either booting with atyfb enabled or disabled.
>  
>  output-device is 0 (PROMDEV_OSCREEN).

Oh, and here's the contents of /proc/fb:

0 ATY Mach64
1 Elite 3D

Booting with fbcon=map:1 works correctly.

ciao,
    ema
