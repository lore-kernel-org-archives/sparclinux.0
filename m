From: David Miller <davem@davemloft.net>
Date: Wed, 13 Feb 2008 06:34:23 +0000
Subject: Re: Issue with linux sunvdc driver and solaris zfs partitions
Message-Id: <20080212.223423.01388702.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <d105c9dd0802071910u45a1554g639ea278b023ceb@mail.gmail.com>
In-Reply-To: <d105c9dd0802071910u45a1554g639ea278b023ceb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "John Cater" <katre50@gmail.com>
Date: Thu, 7 Feb 2008 22:10:48 -0500

> [15473.014047] sunvdc.c:v1.0 (June 25, 2007)
> [15473.031275] sunvdc: VD_OP_GET_VTOC returns error -48
> [15473.031319] vdc_port: probe of vdc-port-0-0 failed with error -48

We only support file and full device exports that use Sun disk
labels.
