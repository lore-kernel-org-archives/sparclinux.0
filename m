From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 30 Jul 2007 00:53:48 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <Pine.LNX.4.61.0707300150430.32022@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Mon, 30 Jul 2007, Julian Calaby wrote:

> On 7/29/07, David Miller <davem@davemloft.net> wrote:
>> The floppy driver cannot be built as a module on sparc32, you must
>> build it in statically because it references an interrupt handler
>> which must be coded in assembler which therefore cannot be easily
>> exported to modules.
>
> Stupid question, but: Why is it possible to select it to compile as a
> module when it cannot?
>

Because no one has got arround to fixing the build option :-).
Sparc32 is only partially maintained at the moment so little things like 
this get left out of updates.

> -- 
>
> Julian Calaby
>
> Email: julian.calaby@gmail.com
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
