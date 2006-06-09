From: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
Date: Fri, 09 Jun 2006 15:23:16 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap() (was Re: 2.6.17-rc3+git seems to corrupt dpkg databa
Message-Id: <20060609152312.GB2371@cassis>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

7 days, 14 hours, 26 minutes, 10 seconds ago, 
David Miller wrote:
> Anyways, give this patch below a test, it should fix things.
> It is against the current 2.6.17 tree.

It seems to fix the bug (according to `mremap-stress' and with
2.6.17-rc6) on my U5 (I was hoping it would also somehow allow X.org 7
to run but unfortunately it doesn't ;-)).

Thanks!

Ludovic.

