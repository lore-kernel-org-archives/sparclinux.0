From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2007 05:06:01 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <20070725.220601.123890960.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 26 Jul 2007 05:31:16 +0100 (BST)

> Do your util-linux-ng changes include an option to update the VTOC
> without changing the partition details?

Yes, if the version, sanity, or num_partitions fields are wrong
fdisk will print out a warning message informing the user
that fdisk has fixed up these values in it's internal copy
and that the user can give the "w" command to write that fixed
copy back to disk.
