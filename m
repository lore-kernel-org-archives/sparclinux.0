From: David Miller <davem@davemloft.net>
Date: Fri, 31 Oct 2014 19:50:05 +0000
Subject: Re: [PATCH] sunvdc: don't call VD_OP_GET_VTOC
Message-Id: <20141031.155005.1333167345031652160.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1414698935-7520-1-git-send-email-dwight.engen@oracle.com>
In-Reply-To: <1414698935-7520-1-git-send-email-dwight.engen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 30 Oct 2014 15:55:35 -0400

> The VD_OP_GET_VTOC operation will succeed only if the vdisk backend has a
> VTOC label, otherwise it will fail. In particular, it will return error
> 48 (ENOTSUP) if the disk has an EFI label. VTOC disk labels are already
> handled by directly reading the disk in block/partitions/sun.c (enabled by
> CONFIG_SUN_PARTITION which defaults to y on SPARC). Since port->label is
> unused in the driver, remove the call and the field.
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>

Yep, makes perfect sense.

Applied and queued up for -stable, thanks.
