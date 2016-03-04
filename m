From: alexmcwhirter@triadic.us
Date: Fri, 04 Mar 2016 21:21:56 +0000
Subject: Re: Kernels 4.+ are breaking =?UTF-8?Q?rsync=3F?=
Message-Id: <cb4793e6db600400fda536e2fc22ef4c@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <e27cb22ab17f1f6e5b795c55b90daa01@triadic.us>
In-Reply-To: <e27cb22ab17f1f6e5b795c55b90daa01@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2016-03-04 15:47, John Paul Adrian Glaubitz wrote:
> On 03/05/2016 05:24 AM, alexmcwhirter@triadic.us wrote:
>> I do find it odd that the Debian port seems to be working fine. I'm
>> going to give the latest kernel on a try on this box. Previously i had
>> only tried up to the latest rendition of 4.1. If it's still broken I
>> will boot up Debian and see what's going on. Hopefully it isn't 
>> hardware
>> specific "This is a cheetah box IIRC"
> 
> It might be a toolchain issue.
> 
> Are you using the default compiler options or did you tune anything?
> 
> Adrian

I'm just passing "-mcpu=ultrasparc -mtune=ultrasparc -O2 -pipe" on 
cflags, chost is sparc64-uknown-linux-gnu... which should be a fairly 
standard setup. I would also imagine that a toolchain issue would also 
cause issues on kernels older than 3.19.

I wonder if this is some odd interaction between OpenSSL and the kernel. 
I've been compiling OpenSSL without the assembly optimization because 
the build system needs fixed a bit on the Gentoo end for sparc64. SCP 
also exibits similar behaviour to rsync and both use ssh to do their 
respective jobs. That's literally only thing im aware of that deviates 
from the typical gentoo structure.

Anyways, im giving Debian a shot now. The installer refused to format my 
boot partition as ext2, so i had to use ext3. That probably a little off 
topic though, so ill keep you updated on my findings.

