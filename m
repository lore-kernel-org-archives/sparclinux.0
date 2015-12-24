From: David Miller <davem@davemloft.net>
Date: Thu, 24 Dec 2015 16:43:46 +0000
Subject: Re: [PATCH] tty/serial: Skip 'NULL' char after console break when sysrq enabled
Message-Id: <20151224.114346.690529944368284120.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450896933-192269-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1450896933-192269-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vijay.ac.kumar@oracle.com
Cc: gregkh@linuxfoundation.org, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, karl.volz@oracle.com

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 23 Dec 2015 10:55:33 -0800

> When sysrq is triggered from console, serial driver for SUN hypervisor
> console receives a console break and enables the sysrq. It expects a valid
> sysrq char following with break. Meanwhile if driver receives 'NULL'
> ASCII char then it disables sysrq and sysrq handler will never be invoked.
> 
> This fix skips calling uart sysrq handler when 'NULL' is received while
> sysrq is enabled.
> 
> Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Acked-by: Karl Volz <karl.volz@oracle.com>

Applied, thank you.
