From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 27 Aug 2004 23:39:03 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <20040827163903.0141f798.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 28 Aug 2004 00:34:12 +0100
"C.Newport" <crn@netunix.com> wrote:

> FWIW, I saw this problem in a completely different non-linux context
> a while ago. It is possible, if the code is tight enough, for modern fast
> processors to overwrite the character in a USART transmit register
> before the USART has moved it down the internal buffer. 
> Introducing a suitable delay fixed it.

We protect this by spinning on the sunsab control register waiting
for it to say "character sent and FIFO empty, ready for next char".

It's busted udelay() on sparc64 which is causing this problem.
