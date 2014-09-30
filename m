From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 21:38:15 +0000
Subject: Re: [PATCH] sunvdc: add cdrom and v1.1 protocol support
Message-Id: <20140930.173815.491794277700175951.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1411134134-26584-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1411134134-26584-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Fri, 19 Sep 2014 09:42:14 -0400

> Interpret the media type from v1.1 protocol to support CDROM/DVD.
> 
> For v1.0 protocol, a disk's size continues to be calculated from the
> geometry returned by the vdisk server. The geometry returned by the server
> can be less than the actual number of sectors available in the backing
> image/device due to the rounding in the division used to compute the
> geometry in the vdisk server.
> 
> In v1.1 protocol a disk's actual size in sectors is returned during the
> handshake. Use this size when v1.1 protocol is negotiated. Since this size
> will always be larger than the former geometry computed size, disks created
> under v1.0 will be forwards compatible to v1.1, but not vice versa.
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>

Applied.
