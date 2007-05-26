From: Dave Airlie <airlied@linux.ie>
Date: Sat, 26 May 2007 20:32:10 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <Pine.LNX.4.64.0705262129480.1268@skynet.skynet.ie>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>
> My knowledge of the DRM is weak, but as I understand it, the only time
> it is used is by the ioctl handlers, and not by userspace. I've added
> Dave Airlie to the CC list, hopefully he can enlighten us as to where
> else cmpxchg is used.
>
>> Unless something %100 inside of the kernel will be the only consumers
>> of this, I'd recommend not adding it.  You can't let anything part of
>> a userland API try to make use of it, and DRM definitely falls into
>> that category.
>>
>
> istr there was a contentious thread on linux-arch about using cmpxchg in
> generic code a while ago. So it's possible architectures with crappy
> atomic support will need some kind of hack like this to even be able to
> use generic code in the future.
>
>> Sparc 32-bit barely has PCI let alone 3D graphics cards.
>>

the DRM can use cmpxchg in userspace, to implement DRM_CAS, have a look in 
drm git libdrm/xf86drm.h we appear to have a sparc implementation, this 
gives us fast userspace locking, however if an arch doesn't implement 
DRM_CAS we fallback to the heavyweight in-kernel lock,

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

