From: Bob Breuer <breuerr@mc.net>
Date: Fri, 23 Jun 2006 16:40:17 +0000
Subject: Re: [PATCH] sparc32: fix iommu_flush_iotlb end address
Message-Id: <449C1971.3090001@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <449774DB.6090201@mc.net>
In-Reply-To: <449774DB.6090201@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl wrote:
>     Thanks for this patch. I shall test it in smp configuration. Do you
> know the release of the official kernel that supports sparc32 smp mode ?
> I have tested the 2.6.17.1 kernel without success (ot doesn't build due
> to a undefined symbol...).

For sparc32 smp without extra patches, 2.6.17.X won't work.  You will
need at least 2.6.17-git2 or newer.

Bob
