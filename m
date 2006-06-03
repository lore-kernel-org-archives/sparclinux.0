From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jun 2006 06:08:45 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <20060602.230845.104645550.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 2 Jun 2006 16:17:29 +0300 (EEST)

> Works on my Ulta 5 - without the patch I get the error at once and with 
> the patch I get no error for half an hour.

Great, please watch for any dpkg database file corruption.  That's the
reason all of this started :)
