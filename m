From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jun 2017 19:13:46 +0000
Subject: Re: [v2 0/8] Early boot timestamp
Message-Id: <20170612.151346.471694889005398007.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497286107-974183-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497286107-974183-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 12:48:19 -0400

> Changelog:
> 	v1 - v2:
> 		- Early boot timestamps are now available on all 64-bit
> 		  sparc processors
> 		- New hot-patched get_tick() function.

Other than the two pieces of feedback I gave you, these changes look
great.

Please fix those up, retest, and repost the series and I'll apply it.

Thanks!
