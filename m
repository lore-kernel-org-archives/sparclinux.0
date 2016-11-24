From: alexmcwhirter@triadic.us
Date: Thu, 24 Nov 2016 17:43:01 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <c746adcf11943d7327e1e2bdead5648a@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2016-11-24 12:33, John Paul Adrian Glaubitz wrote:
> Hi Dave!
> 
> As promised in another mail earlier today, here is the current patch
> changes that we are currently using on top of silo HEAD to build
> it as a 64-bit package in Debian unstable (sparc64).
> 
> The silo package has been shipped in Debian with 64-bit support for
> a while now without any major issues for most people. So far, I
> only know of two cases where people had issues but this seems to
> affect Serengeti and Amazon machines only and not a result of this
> particular patch.
> 
> Thanks,
> 
> Adrian
> 
>> [1] http://marc.info/?l=linux-sparc&m7363964605901&w=2

Just as a side note, i can personally verify that both Debian SILO and 
current SILO are broken on Serengeti / Amazon in the same way. 64 Bit 
patches make no absolutely difference here.
