From: David Miller <davem@redhat.com>
Date: Mon, 15 May 2017 19:36:46 +0000
Subject: Re: [PATCH net-next 0/2] ldmvsw: port removal stability
Message-Id: <20170515.153646.1717852985305748981.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1494870668-65047-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1494870668-65047-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 15 May 2017 10:51:06 -0700

> Under heavy reboot stress testing we found a couple of timing issues
> when removing the device that could cause the kernel great heartburn,
> addressed by these two patches.

These are pretty legit bug fixes so I've applied this series to net,
thanks.
