From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 24 Feb 2021 12:59:59 +0000
Subject: Re: Newer kernels fail to boot on a U450?
Message-Id: <32382ebd-e4d6-106c-76d9-24b8a90ab89e@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
In-Reply-To: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Frank!

On 2/24/21 1:43 PM, Frank Scheiner wrote:
>> There is a stability issue on newer kernels on older hardware that is currently
>> being debugged though [1].
> 
> Didn't know of that thread. I wonder if this could be the reason for the
> crashes on my v480 and v490, though they happened already during kernel
> boot.

I think this particular issue concerns mainly stability issues under high load.

I have observed that the UltraSPARC IIIi we have in Debian will crash under
high load with the newer kernels but runs very stable on older kernels.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
