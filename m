From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 23:42:28 +0000
Subject: Re: [PATCH v2] sparc32, leon: Make leon_dma_ops avaiable when !CONFIG_PCI
Message-Id: <20140909.164228.1099340284543391478.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1409657655-17846-1-git-send-email-andreas@gaisler.com>
	<1410162532-25159-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1410162532-25159-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, sam@ravnborg.org, linux-kernel@vger.kernel.org, software@gaisler.com

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon,  8 Sep 2014 09:48:52 +0200

> The leon_dma_ops struct is needed for leon regardless of PCI configuration.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
> Changes from v1: Fixed typo in commit message

Applied.
