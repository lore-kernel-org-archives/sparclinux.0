From: David Miller <davem@davemloft.net>
Date: Fri, 12 Dec 2014 02:53:54 +0000
Subject: Re: [PATCH] sunvdc: fix module unload/reload
Message-Id: <20141211.215354.391412543973706540.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1418318742-16406-1-git-send-email-dwight.engen@oracle.com>
In-Reply-To: <1418318742-16406-1-git-send-email-dwight.engen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 11 Dec 2014 12:25:42 -0500

> Free resources allocated during port/disk probing so that the module may be
> successfully reloaded after unloading.
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>

Applied.
