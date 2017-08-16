From: David Miller <davem@davemloft.net>
Date: Wed, 16 Aug 2017 18:30:45 +0000
Subject: Re: [PATCH] sparc64: remove unnecessary log message
Message-Id: <20170816.113045.1324432729723702863.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1502906950-20710-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1502906950-20710-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Wed, 16 Aug 2017 11:09:10 -0700

> There is no need to log message if ATU hvapi couldn't get register.
> Unlike PCI hvapi, ATU hvapi registration failure is not hard error.
> Even if ATU hvapi registration fails (on system with ATU or without
> ATU) system continues with legacy IOMMU. So only log message when
> ATU hvapi successfully get registered.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>

Applied, thanks.
