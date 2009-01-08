From: David Miller <davem@davemloft.net>
Date: Thu, 08 Jan 2009 21:33:39 +0000
Subject: Re: [PATCH v2 0/5] Eliminate most of sparc_ksyms_*.c
Message-Id: <20090108.133339.76399313.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4965F1C6.1090700@gmail.com>
In-Reply-To: <4965F1C6.1090700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Fri, 9 Jan 2009 08:23:41 +1100

> My stance on this is: as this functionality that is defined in
> assembler, having nasty C code is acceptable - providing that it's
> documented. (which we could improve somewhat)

Note, we can probably do this automatically without having
to define a symbol exporting macro for assembler code.

Just add some annotation to the assembler files, then
some script or similar processes the *.S files looking
for the symbol export annotations and uses that to
generate the ksyms.c file.

Nice project for someone who is bored :)
