From: David Miller <davem@davemloft.net>
Date: Wed, 10 Jun 2015 09:18:33 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150610.021833.1402529650339691081.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 10 Jun 2015 09:50:06 +0200

> So it means the userland code doesn't run the same on the various
> CPU. How are we supposed to do with static binaries?

Multiarch works perfectly fine in static binaries, just the same as it
does with dynamically linked executables.

Normally static binaries do not use PLT entries, but with multiarch
it does, so that the proper routine can be resolved at run time just
as it would via the dynamic linker.

> Disabling multiarch support improves a lot the stability on these
> machines.

By disabling it you are creating an even worse situation, for the
reasons I've discussed already, plus guess what I test when I'm
doing development?
