From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 18 Jul 2005 22:41:50 +0000
Subject: Re: [patch 4/4] sbus/vfc_i2c: remove sleep_on() usage
Message-Id: <20050718.154150.78706200.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: domen@coderock.org
Date: Mon, 20 Jun 2005 23:50:35 +0200

> Use wait-queue directly instead of the deprecated sleep_on()
> function. This required adding a local wait-queue. Also use new (added in
> separate patch to K-J) usecs to jiffies function to convert value.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>

Applied, thanks.
