From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 18 Jul 2005 22:39:28 +0000
Subject: Re: [patch 2/4] sbus/envctrl: replace schedule_timeout() with
Message-Id: <20050718.153928.71086329.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: domen@coderock.org
Date: Mon, 20 Jun 2005 23:50:33 +0200

> Use msleep_interruptible() instead of
> schedule_timeout() to guarantee the task delays as expected. Change the units of
> poll_interval to msecs as it is only used in this delay.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>

Applied, thanks.
