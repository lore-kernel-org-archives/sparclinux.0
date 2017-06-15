From: David Miller <davem@davemloft.net>
Date: Thu, 15 Jun 2017 18:23:14 +0000
Subject: Re: [PATCH net-next] sunvnet: restrict advertized checksum offloads to just IP
Message-Id: <20170615.142314.2129688024540050765.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497480217-391315-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1497480217-391315-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 14 Jun 2017 15:43:37 -0700

> As much as we'd like to play well with others, we really aren't
> handling the checksums on non-IP protocol packets very well.  This
> is easily seen when trying to do TCP over ipv6 - the checksums are
> garbage.
> 
> Here we restrict the checksum feature flag to just IP traffic so
> that we aren't given work we can't yet do.
> 
> Orabug: 26175391, 26259755
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>

Applied, but this bug must be fixed properly and ipv6 checksumming
properly supported.

Thanks.
