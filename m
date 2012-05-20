From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 21:40:50 +0000
Subject: Re: [RFC PATCH] sparc32: make srmmu helpers leon compatible
Message-Id: <20120520.174050.798486487552392738.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120519200321.GA7617@merkur.ravnborg.org>
In-Reply-To: <20120519200321.GA7617@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 23:34:52 +0200

> On Sun, May 20, 2012 at 05:24:01PM -0400, David Miller wrote:
>> Second, have you audited to make sure that none of this
>> code runs before the patchup code does?
> Yes - but a lot of other places that require patching will run
> long time before (wof.S, wuf.S etc). At least I assume so.

The wof.S and wuf.S cases would only execute after we've started
userland, as that code is used to validate the user stack in the
register window store area.

Therefore it won't run unless PSR_PS is clear in %psr or there
are user register windows in the cpu.

Neither of which will be true during early boot.

You should therefore be fine except for the bits in head_32.S
which you'll need to use tests and branches for anyways.
