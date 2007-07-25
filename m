From: David Miller <davem@davemloft.net>
Date: Wed, 25 Jul 2007 19:19:26 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <20070725.121926.59497482.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 25 Jul 2007 17:47:29 +0100 (BST)

> Add in fix to prevent the VTOC table being used if it is not present
> (it was not implemented until Solaris 2.x so SunOS 4.1.x will not have
> valid VTOC data) and correct the Solaris x86 number of partitions (slices).
> 
> Signed-off-by: Mark Fortescue <mark@mtfhpc.demon.co.uk>

All fdisk and parted implemented before about a few weeks ago under
Linux do not set the sanity value, they don't even set the version
field.

So you cannot add this change without breaking pretty much every
Linux/Sparc installation out there, it will be years before everyone
has fixed up disk labels.

In fact it is a feature that the Linux Sun disk label code was so
permissive, Solaris refuses to recognize the disk label created by
existing Linux systems and this causes a lot of problems.

Sorry you cannot make this change without breaking things severely
even though I understand what you want to make it.

