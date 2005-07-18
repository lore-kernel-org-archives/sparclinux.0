From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 18 Jul 2005 22:38:39 +0000
Subject: Re: [patch 1/4] sbus/aurora: replace schedule_timeout() with
Message-Id: <20050718.153839.92587684.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: domen@coderock.org
Date: Mon, 20 Jun 2005 23:50:32 +0200

> Use msleep_interruptible() instead of
> schedule_timeout() to guarantee the task delays as expected.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> Signed-off-by: Domen Puncer <domen@coderock.org>

Applied, thanks.
