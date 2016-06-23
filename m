From: chase rayfield <cusbrar1@gmail.com>
Date: Thu, 23 Jun 2016 19:42:00 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <CACwypyM8rg+=dJpi=qK66RKb+WgP02ssLYuFAkNETu=mGVbNMg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just to clarify, unlike variable length ISAs Sparc has fixed 32bit and
64bit ISAs... Sparc v8+ is 32bits for every instruction executed while
for Sparc v9 it is 64bits for every instruction. Thus the overhead is
not just in pointers etc.. as is often the case on variable length
architectures. 64bit instructions potentially waste more cache as well
as use 2x the memory bandwidth. Also note that Sparc does not mix
32bit and 64bit instructions I presume that when a 64bit kernel is
executing 32bit code it switches back out of 64bit mode when returning
to userland...

You may wonder what advantage being so strict about instruction length
is... for one the Ultrasparc instruction decode stages have in the
past at least been wave pipelined... which as you may imagine is made
easier by having regular instruction lengths as well as infrequent
switches between 64bit and 32bit mode.



On Thu, Jun 23, 2016 at 3:31 PM, David Miller <davem@davemloft.net> wrote:
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date: Thu, 23 Jun 2016 20:42:31 +0200
>
>> On 06/23/2016 05:06 PM, David Miller wrote:
>>> I think what irks people the most about what happened, is that the
>>> choosen a path is not the most optimal situation for the target
>>> platform.
>>
>> Why should it be any different for sparc64 than for ppc64el, amd64,
>> arm64, mips64el and so on? Is SPARC so extremely inefficient with
>> 64-bit pointers? I don't think so.
>
> It makes a significant performance and memory footprint difference.
>
> This is irrefutable.
>
> And all of those binaries you say "don't matter" take up memory,
> swap space, etc.  And if you add this up for the entire system
> it's non-trivial.
>
> Multiply this by some factor N when virtualization is involved.
>
>> I don't think it makes sense to compile things like dateutils with
>> 32-bit pointers for performance reasons. Also, I would assume that
>> modern compilers are able to optimize the code well enough that the
>> difference between 32-bit and 64-bit pointers isn't too big that
>> it justifies the effort.
>
> No compiler is going to optimize away the pointers in the data
> structures, and thus get all of those cache line and tlb misses back.
>
> I do all of my work with 32-bit gcc binaries, even thought I often am
> using tools I've built myself.
>
> It makes a huge difference.
