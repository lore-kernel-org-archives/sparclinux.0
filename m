From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 02 Dec 2012 22:22:30 +0000
Subject: Re: SPARC kernel build (piggyback) fails with binutils 2.23.1
Message-Id: <CAGRGNgUZc9Zw0KyT72zYLNrScuLV+0C6PyMthShfTC7bW+f7-Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20121202165004.GA3091@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20121202165004.GA3091@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Aaro,

On Mon, Dec 3, 2012 at 3:50 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> Kernel (3.7-rc7) build is failing with binutils 2.23.1, because _end is
> no longer absolute for some reason and piggyback can't find it:
>
>         $ tail -3 System.map
>         000000000086bcb8 b net_header
>         000000000086bcc0 B __bss_stop
>         000000000086bcc0 B _end
>
>         [...]
>
>           kernel: arch/sparc/boot/image is ready
>           HOSTCC  arch/sparc/boot/piggyback
>           ELFTOAOUT arch/sparc/boot/tftpboot.img
>         PT 0 Entry: Loadable to 0x400000[0x46bcc0] from 0x0[0x40ed60] align 0x100000
>         PT 1 Entry: Note
>         PT 2 Entry: unknown
>           PIGGY   arch/sparc/boot/tftpboot.img
>         Could not determine start and end from System.map
>         make[6]: *** [arch/sparc/boot/tftpboot.img] Error 1
>
> Is this a bug in binutils, or is the check in piggyback too strict?

Given that the addresses below are the same as the addresses above,
I'm suspecting that the test is too strict.

I assume that you have a sparc64 system you can reliably boot with
TFTP, could you try changing the code in the "end_line" function (line
91) to look for 'B' symbols and check that it still boots correctly?
I'd cook you up a patch, but I'm away from my development machine at
the moment.

If that works, we'll have to figure out a better test for this.

> With older binutils (2.22) the symbol is still "A":
>
>         $ tail -3 System.map
>         000000000086bcb8 b net_header
>         000000000086bcc0 A __bss_stop
>         000000000086bcc0 A _end

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
