From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 04 Jun 2017 15:09:10 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <f7c11c48-634b-a930-0f64-edb8b066157d@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170602091717.GA7452@physik.fu-berlin.de>
 <20170602.102259.363059784928463769.davem@davemloft.net>
 <1f8e2488-d051-7688-2d40-089f4acab6ce@physik.fu-berlin.de>
 <20170602.132809.1754806777743128355.davem@davemloft.net>
 <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
 <20170604144044.GK26922@waldemar-brodkorb.de>
In-Reply-To: <20170604144044.GK26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi Waldemar!

On 06/04/2017 04:40 PM, Waldemar Brodkorb wrote:
>> So, in your point of view it's perfectly fine if an application is able
>> to crash the whole kernel with just user privileges?
>>
>> Shouldn't the kernel be able to cope with that?
> 
> I think he means your kernel you are running might be miscompiled
> with gcc 7.1.

The kernel wasn't compiled by 7.1. It was built with 6.3:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.8 2017/02/22 13:51'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Linux version 4.12.0-rc1-sparc64-smp (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170510 (Debian 6.3.0-17) ) #1 SMP Debian
4.12~rc1-1~exp1~sparc64 (2017-05-17)

> What kernel version you are running?

This has been haunting us since around kernel 4.6 or so. It also
only shows when building with many parallel jobs.

> Which compiler you used to generate the running kernel?

6.3.0 20170510 from the gcc-6 branch.

> If it is gcc 7.1, what is if you try to
> reproduce the crash with the same kernel version compiled with gcc
> 6.3?

It's simply gcc-7's testsuite that's crashing the kernel since kernel
versions around 4.6. We haven't done any kernel compiles with gcc-7.1
yet since gcc-7.1 not yet the default compiler, we're just building the
package in Debian experimental.

> Wouldn't this show if it is a compiler or kernel bug?

Yes and I think the data suggests it's rather a kernel bug than a bug
in gcc.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
