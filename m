From: David Miller <davem@davemloft.net>
Date: Wed, 20 Apr 2016 15:57:57 +0000
Subject: Re: Please advise on dealing with compiler issue
Message-Id: <20160420.115757.842220298792561835.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <57179B52.5090200@oracle.com>
In-Reply-To: <57179B52.5090200@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 20 Apr 2016 09:08:02 -0600

> 3. .byte 0x83,0x43,0x80,0x00 - This is byte coded equivalent of "rd
> %asr14, %g1". This works independent of binutils version but is ugly
> and requires pre-assigning a register to read MCDPER into, which does
> not help compiler with optimization.

The register read is so expensive relative to executing other
instructions, that I don't think compiler optimizations are a valid
consideration at all.

This is the only valid option given the constraints, and you should
use ".word xxxxx" just like we do for other similar hard coded
instruction sequences.

Thanks.
