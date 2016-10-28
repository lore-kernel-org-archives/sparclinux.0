From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 28 Oct 2016 09:05:41 +0000
Subject: Re: Fwd: Fujitsu PrimePower 450 with SPARC64 V & Linux support
Message-Id: <581314E5.4070309@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <B4E4747C-3A32-435B-A882-F89338148733@gmail.com>
 <CAC=+HvZpz32O5oER7=bM84PQU3xgwJDTj4iuuYssy69pkNGGvQ@mail.gmail.com>
 <CAC=+HvYmY7sQ=MEf9eveKMqHrP8zKcmGS9ZE6uR9=7bneMeiqA@mail.gmail.com>
In-Reply-To: <CAC=+HvYmY7sQ=MEf9eveKMqHrP8zKcmGS9ZE6uR9=7bneMeiqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Allan Tsakuhhin <allan.tsakuhhin@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mroos@linux.ee



On 10/27/2016 08:50 PM, Allan Tsakuhhin wrote:
> I am trying to build Linux system on Fujitsu PrimePower 450 running by
> SPARC64 V CPUs. Does anyone have supportive materials (manuals,
> overviews, specs) about Fujitsu PP450 and SPARC64 V CPUs. Every kind
> of source material may be useful!
> 
> All I have found from Internet, there is no Linux support to SPARC64
> V. Persons, who have tried to get it work before, please give me some
> advice and let me know about your results.

Have you tried pre-built images on this machine:

Debian:

https://people.debian.org/~glaubitz/debian-cd/2016-05-04/debian-9.0-sparc64-NETINST-1.iso


Linux for SPARC (LFS):

https://oss.oracle.com/linux-sparc/isos/linux-sparc-1.0-DVD.iso

?

The LFS image is pretty old, and, per my knowledge, was not tried on the
system type you are referring to.

Thanks.

> 
> For now I have build a Linux kernel from SPARC Enterprise T2000 as a
> donor kernel and trying to get it work on SPARC64 V.
> 
> 
> Allan Tsakuhhin
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
