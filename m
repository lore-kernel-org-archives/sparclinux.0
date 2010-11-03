From: Jan Engelhardt <jengelh@medozas.de>
Date: Wed, 03 Nov 2010 11:01:59 +0000
Subject: Re: Linux 2.6.36-rc8 won't boot
Message-Id: <alpine.LNX.2.01.1011031151180.678@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 2010-11-02 20:08, David Miller wrote:

>
>Jan, match the program counter and the register values with
>things in your System.map and kernel image.
>
>The values are meaningless to me, you need to do the actual
>work to effectively get this into a debuggable state.
>
>Just dumping it to me is worthless.

AFAICT this is SILO acting up. (It's reminiscient of 
silo.git:70643a1984ce25b701ec77ac29f8194676bf30c5, but I doubt it's the 
same.)
I gotta netboot, too bad we don't have an intermediate network loader 
stage (such as pxelinux on x86) that is able to allocate enough
memory to be able to load images >10MB.
