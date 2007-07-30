From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jul 2007 03:58:09 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <20070729.205809.104037495.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 30 Jul 2007 10:09:33 +1000

> On 7/29/07, David Miller <davem@davemloft.net> wrote:
> > The floppy driver cannot be built as a module on sparc32, you must
> > build it in statically because it references an interrupt handler
> > which must be coded in assembler which therefore cannot be easily
> > exported to modules.
> 
> Stupid question, but: Why is it possible to select it to compile as a
> module when it cannot?

There isn't an easy way to describe this in the Kconfig language
at this time.
