From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sun, 26 Nov 2017 21:53:10 +0000
Subject: Re: Silo on RAID 1
Message-Id: <1511733190.1834.47.camel@xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <1511689792.4483.9.camel@xs4all.nl>
In-Reply-To: <1511689792.4483.9.camel@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2017-11-26 at 21:52 +0100, Frans van Berckel wrote:
> Hi Chase,
> 
> Are you sure? Because the Silo readme from David's tree calls ...
> 
> "Note that numbers start at 0, rather than Linux's convention of
> starting at 1, so sd(0,3,1) is /dev/sda2."
> 
> Please checkout docs/README.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/silo.git/

A bit lower from the same readme calls...

"With old proms, you type prom paths as dev(X,Y,Z) [e.g. sd(0,3,1)].
With new proms, you type the open boot prom style strings such as
/iommu/sbus/espdma/esp/sd@1,0 terminated with a semicolon (;) to
specify disk. Then the partition can be specified, defaulting to the
(optional) partition=Z line in the main section in silo.conf. /dev/sda2
is '2'."

But changing 0 to 1, I am still getting ...

/etc/silo.conf appears to be valid
Fatal error: File systems other than ext2, ext3, ufs and romfs not yet
supported.

So I have to look over something.

Thanks,

Frans van Berckel
