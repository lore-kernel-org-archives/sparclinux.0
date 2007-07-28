From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 28 Jul 2007 15:08:21 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <Pine.LNX.4.61.0707281535590.27460@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Julian,

One problem is that the floppy disk must NOT be built as a module on 
sparc32. Either remove floppy support or build it into the kernel.
CONFIG_BLK_DEV_FD=m will fail.

The other problem can easilly be dealt with by not building the 
CONFIG_PARPORT_AX88796 module. If you rearly need this module then some 
debugging will be needed to work out what has been broaken.

Sparc32 apears to have a 4M limit in memory space for the boot 
loader+kernel. For me (with SunOS 4.x boot loader) this equates to a 
maximum kernel size of app 2.9MB. I understand that for SILO it is 
arround 2.7MB.

Cut out any unnessesary debugging capabilities in the kernel 
(eg. things like CONFIG_SLUB_DEBUG, CONFIG_DEBUG_BUGVERBOSE).

Do not build any un-nessesary modules (if you remove too many of them, 
you can always rebuild with the missing ones later on when you know you 
can get create a working kernel).

There is an important bug fix for sparc32 (arch/sparc/lib/memset.S). Check 
that this has been applied (my mail client will nodought mangle it):

--- linux-2.6/arch/sparc/lib/memset.S   2007-04-30 01:29:00.000000000 +0100
+++ linux-test/arch/sparc/lib/memset.S  2007-07-24 20:12:19.000000000 +0100

@@ -162,7 +163,7 @@ __bzero:
  8:
          add    %o0, 1, %o0
         subcc   %o1, 1, %o1
-       bne,a   8b
+       bne     8b
          EX(stb %g3, [%o0 - 1], add %o1, 1)
  0:
         retl

Regards
 	Mark Fortescue.

On Sat, 28 Jul 2007, Julian Calaby wrote:

> On 7/28/07, Julian Calaby <julian.calaby@gmail.com> wrote:
>> These errors relate to iounmap and ioremap being unavailable. (and
>> another symbol which I cannot remember)
>>
>> This makes no sense as these functions are definitely compiled into the kernel.
>>
>> I will provide more detailed error messages later as this system is
>> currently attempting another kernel compilation.
>
> Ok, the compile failed, and the errors are:
>
>  Building modules, stage 2.
>  MODPOST 165 modules
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
>
> Again,
>
> Thanks in advance,
>
> -- 
>
> Julian Calaby
>
> Email: julian.calaby@gmail.com
>
