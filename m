From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jun 2013 09:14:17 +0000
Subject: Re: [PATCH 1/1] sparc64 address-congruence property
Message-Id: <20130619.021417.1755333125183288447.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1370976891-11648-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1370976891-11648-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 11 Jun 2013 14:54:51 -0400

> From: bob picco <bpicco@meloft.net>
> 
> The Machine Description (MD) property "address-congruence-offset" is
> optional. According to the MD specification the value is assumed 0UL when
> not present. This caused early boot failure on T5.
> 
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

Applied and queued up for -stable, thanks.
