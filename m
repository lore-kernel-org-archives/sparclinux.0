From: Waldemar Brodkorb <wbx@openadk.org>
Date: Sun, 04 Jun 2017 14:40:45 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170604144044.GK26922@waldemar-brodkorb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170602091717.GA7452@physik.fu-berlin.de>
 <20170602.102259.363059784928463769.davem@davemloft.net>
 <1f8e2488-d051-7688-2d40-089f4acab6ce@physik.fu-berlin.de>
 <20170602.132809.1754806777743128355.davem@davemloft.net>
 <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
In-Reply-To: <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: David Miller <davem@davemloft.net>, wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi Adrian,
John Paul Adrian Glaubitz wrote,

> On 06/02/2017 07:28 PM, David Miller wrote:
> >> Isn't a bug in the kernel if an application is able to crash to the point
> >> that the machine has to be hard-rebooted?
> > 
> > It can be a bug in the compiler too and not necessarily the kernel's
> > fault which is what I think is happening in your case.
> 
> So, in your point of view it's perfectly fine if an application is able
> to crash the whole kernel with just user privileges?
> 
> Shouldn't the kernel be able to cope with that?

I think he means your kernel you are running might be miscompiled
with gcc 7.1.

What kernel version you are running? Which compiler you used to
generate the running kernel? If it is gcc 7.1, what is if you try to
reproduce the crash with the same kernel version compiled with gcc
6.3?
Wouldn't this show if it is a compiler or kernel bug?

best regards
 Waldemar
