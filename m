From: David Miller <davem@davemloft.net>
Date: Fri, 26 Oct 2018 18:30:12 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20181026.113012.27569585433135041.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 26 Oct 2018 14:41:53 +0200

>> It should not crash the machine and here with an upstream kernel it does not for me.
> 
> Interestingly, we couldn't reproduce the issue on the SPARC-T5 anymore either. It
> definitely crashes the Sun Fire 2000 used for development of the Free Pascal
> compiler though, just re-tested:

I tested it on my Ultra45

Please reproduce with a vanilla upstream kernel.  I think some of the local
debian kernel patches might be causing this.

Also, wrt. freepascal, as I described in my email, the link of that
binary is causing the NOP _start function to be set as the entry
point.

That can't be right, whatever ends up as the entry point should end up
calling 'main' so that the program actually runs.
