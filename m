From: crn@post.netunix.com
Date: Wed, 20 Apr 2011 07:39:48 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <alpine.LNX.2.00.1104200832480.20838@post.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Wed, 20 Apr 2011, Daniel Hellstrom wrote:

>> 
> I agree that it would be nicer, however I think the SUNs will never be booted 
> on CPU1 anyway? Anyways, I think this should go into another patch series.

You cannot assume this, sun4d and AFAIK all 64bit systems will boot on
the first non-blacklisted CPU found.
For example, it is perfectly OK to have no CPU present on board0 slot0
in which case the SS1000 will boot using CPU1.

