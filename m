From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2017 02:26:04 +0000
Subject: Re: [PATCH V2] vDSO for SPARC
Message-Id: <20170721.032604.1193284336846567945.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1499268125-877874-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1499268125-877874-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Wed,  5 Jul 2017 11:22:05 -0400

> Following patch is based on work done by Nick Alcock on 64-bit vDSO
> for sparc in Oracle linux. I have extended it to include support for
> 32-bit vDSO for sparc on 64-bit kernel.
 ...

This patch looks good so far to me.

I just want to review and think about it some more before applying
it to the sparc-next tree.

BTW, I'm probably the only person outside of your internal team who
knows what a putback is :-)

Thanks!
