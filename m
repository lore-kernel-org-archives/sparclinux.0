From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jun 2016 19:33:34 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <8e7956d5-d343-961c-232b-f358e4629a4d@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/23/2016 09:31 PM, David Miller wrote:
> And all of those binaries you say "don't matter" take up memory,
> swap space, etc.  And if you add this up for the entire system
> it's non-trivial.
> 
> Multiply this by some factor N when virtualization is involved.

On a machine with 8 TiB of memory? I have also never heard anyone complain
about memory issues on x86_64. Are you also running i686 for that reasons?

>> I don't think it makes sense to compile things like dateutils with
>> 32-bit pointers for performance reasons. Also, I would assume that
>> modern compilers are able to optimize the code well enough that the
>> difference between 32-bit and 64-bit pointers isn't too big that
>> it justifies the effort.
> 
> No compiler is going to optimize away the pointers in the data
> structures, and thus get all of those cache line and tlb misses back.

Intel ICC does exactly that. I even provided a reference for that.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
