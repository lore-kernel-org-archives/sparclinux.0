From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 18 Jul 2005 22:40:48 +0000
Subject: Re: [patch 3/4] sbus/bpp: remove sleep_on() usage
Message-Id: <20050718.154048.97293281.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050306222904.42ED41F1F0@trashy.coderock.org>
In-Reply-To: <20050306222904.42ED41F1F0@trashy.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: domen@coderock.org
Date: Mon, 20 Jun 2005 23:50:34 +0200

> Use wait-queue directly instead of the deprecated sleep_on()
> function. This required adding a local wait-queue.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>

This patch no longer applies, the current snooze() implementation
does a schedule_timeout() which seems fine.
