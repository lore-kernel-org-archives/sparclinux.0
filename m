From: David Miller <davem@davemloft.net>
Date: Sun, 29 Jul 2007 05:24:49 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <20070728.222449.104035900.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Sat, 28 Jul 2007 20:38:28 +1000

> On 7/28/07, Julian Calaby <julian.calaby@gmail.com> wrote:
> > These errors relate to iounmap and ioremap being unavailable. (and
> > another symbol which I cannot remember)
> >
> > This makes no sense as these functions are definitely compiled into the kernel.
> >
> > I will provide more detailed error messages later as this system is
> > currently attempting another kernel compilation.
> 
> Ok, the compile failed, and the errors are:
> 
>   Building modules, stage 2.
>   MODPOST 165 modules
> ERROR: "ioremap" [drivers/parport/parport_ax88796.ko] undefined!
> ERROR: "iounmap" [drivers/parport/parport_ax88796.ko] undefined!
> ERROR: "floppy_hardint" [drivers/block/floppy.ko] undefined!
> 
> My .config is attached.
> 
> I know that I am able to eliminate the driver causing the first two
> warnings from my config as I don't have a parport of this type,
> however I feel that the errors it causes are a concern.
> 
> The floppy driver I'd rather like to have compiled though. =)

The floppy driver cannot be built as a module on sparc32, you must
build it in statically because it references an interrupt handler
which must be coded in assembler which therefore cannot be easily
exported to modules.

