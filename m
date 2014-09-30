From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 21:38:21 +0000
Subject: Re: [PATCH] sunvdc: compute vdisk geometry from capacity
Message-Id: <20140930.173821.1403009740835146132.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1411134146-26624-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1411134146-26624-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Fri, 19 Sep 2014 09:42:26 -0400

> The LDom diskserver doesn't return reliable geometry data. In addition,
> the types for all fields in the vio_disk_geom are u16, which were being
> truncated in the cast into the u8's of the Linux struct hd_geometry.
> 
> Modify vdc_getgeo() to compute the geometry from the disk's capacity in a
> manner consistent with xen-blkfront::blkif_getgeo().
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>

Applied.
