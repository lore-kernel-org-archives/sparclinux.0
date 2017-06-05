From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2017 18:59:15 +0000
Subject: Re: [PATCH v2 1/1] sparc: Machine description indices can vary
Message-Id: <20170605.145915.2050424462954224949.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Clarke <jrtc27@jrtc27.com>
Date: Mon, 29 May 2017 20:17:56 +0100

> VIO devices were being looked up by their index in the machine
> description node block, but this often varies over time as devices are
> added and removed. Instead, store the ID and look up using the type,
> config handle and ID.
> 
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id2541

Applied and queued up for -stable, thanks.
