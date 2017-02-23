From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:24:33 +0000
Subject: Re: [PATCH] sunvdc: Add support for setting physical sector size
Message-Id: <20170223.112433.1000870554714862841.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1485976166-31220-1-git-send-email-Liam.Howlett@Oracle.com>
In-Reply-To: <1485976166-31220-1-git-send-email-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Wed,  1 Feb 2017 14:09:26 -0500

> Physical sector size is supported in v1.2 of the vDisk protocol and
> should be set if available.  If protocol version 1.2 is used and the
> physical disk size is unavailable, then the disk is considered busy.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Applied, thanks.
