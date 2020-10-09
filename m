From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 09 Oct 2020 14:49:32 +0000
Subject: Re: SMP is broken on sparc64 with kernel 4.x/5.x
Message-Id: <d4dc8448-fa89-6da7-e499-c4f18e6800fa@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201009161924.c8f031c079dd852941307870@gmx.de>
In-Reply-To: <20201009161924.c8f031c079dd852941307870@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Ruediger!

On 10/9/20 4:40 PM, Wolf Ruediger Spielmann wrote:
> On Fri, 9 Oct 2020 16:30:35 +0200
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> 
>> It mostly affects older machines, the newer machines such as T5220, T5240 and T5 that
>> we have in Debian have no issues with the latest kernel versions.
>>
>> We do have an UltraSPARC IIIi machine that we need to keep at 4.19 as the machine otherwise
>> becomes unstable.
> 
> I have absolute no stability issues.
> It's (in my opinion) pcpu-alloc:
> kernel 4.x/5.x: pcpu-alloc: [0] 0 1 
> kernel 3.x: pcpu-alloc: [0] 0 2 

Interesting. I have not yet seen this issue on any of our Debian development
machines. What distribution are you running? Is this Gentoo?

Our of curiosity, could you give it a go with Debian?

> https://cdimage.debian.org/cdimage/ports/2020-08-19/debian-10.0.0-sparc64-NETINST-1.iso

> Is it fixable? Or will it stay in state "broken" ?

Of course, it would be fixed we know what's wrong.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
