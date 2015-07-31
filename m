From: Kjetil Oftedal <oftedal@gmail.com>
Date: Fri, 31 Jul 2015 06:20:41 +0000
Subject: Re: Debian drops support for sparc
Message-Id: <CALMQjD-REfcWX=ie11UwjarKPmE3QbN5L+ETEA0iBQL2w0Sm2g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150730140453.GA25014@ravnborg.org>
In-Reply-To: <20150730140453.GA25014@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 30/07/2015, David Miller <davem@davemloft.net> wrote:
> From: Josip Rodin <joy@entuzijast.net>
> Date: Thu, 30 Jul 2015 21:22:30 +0200
>
>> On Thu, Jul 30, 2015 at 06:48:24PM +0200, Sam Ravnborg wrote:
>>> > But I think the focus should probably be on the sheer redness of the
>>> > sparc
>>> > columns at:
>>> > https://release.debian.org/jessie/arch_qualify.html (current release)
>>>
>>> >From the link above:
>>> "
>>> sparc
>>>
>>> Upstream Support
>>>
>>> According to the gcc maintainer 32bit code generation as we use it is no
>>> longer supported upstream and we should aim for a switch to 64bit
>>> userland anytime soon.
>>> "
>>>
>>> Is it correct that 32bit gcc is no longer maintained?
>>> I have seen nothing on gcc mailaing list about this.
>>
>> That's from jessie, which was already released. The said note has been
>> removed from the list for stretch.
>
> The thing is, it makes no sense to go to a 64-bit only userland
> distribition.
>
> What does make sense is maybe only supporting sparc64 kernels,
> but with a userland that is built 32-bit targetting v8plus.
>
>> The problem is that numerous other issues - haven't.
>
> It would be nice to narrow things down to the real issues.
>
> The only major blocker I know of is the kernel FPU issue, which is
> what I'm spending all of my sparc cycles on.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi,

As far as I remember Debian dropped Sparc32 support quite a few years ago.
So I guess what is being dropped this time around is the official support for
64-bit kernel + 32-bit/v8plus userland.

Then only the unofficial port of 64-bit kernel + 64-bit userland remains.

Regards,
Kjetil Oftedal
