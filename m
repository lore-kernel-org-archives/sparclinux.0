From: David Miller <davem@davemloft.net>
Date: Sun, 27 May 2007 21:47:02 +0000
Subject: Re: [PATCH] Linux always started with 9600 8N1
Message-Id: <20070527.144702.55507425.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070526.154745.30164056.davem@davemloft.net>
	<Pine.LNX.4.61.0705271816310.7344@yvahk01.tjqt.qr>
	<20070527.141622.30184020.davem@davemloft.net>
In-Reply-To: <20070527.141622.30184020.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jengelh@linux01.gwdg.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 27 May 2007 14:16:22 -0700 (PDT)

> So even writes to so-called 'read-only' sections of the kernel image
> will work and therefore I don't understand what the bug could be other
> than the compiler "optimizing" away the write to the constant string
> in which case the compiler should have warned about it.

I just stared at the drivers/serial/suncore.s assembler a little
bit and this is indeed what appears to be happening, the compiler
is optimizing the stores away completely yet not doing so much
as emitting a warning, how rude :-)

Perhaps there is some warning option that isn't enabled which
would have caught this...

Thanks a lot for your patch, I'll apply it.
