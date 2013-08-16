From: Alasdair G Kergon <agk@redhat.com>
Date: Fri, 16 Aug 2013 11:38:29 +0000
Subject: Re: [PATCH] dm cache: Avoid conflicting remove_mapping() in mq policy
Message-Id: <20130816113829.GM1762@agk-dp.fab.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1374825451-30463-1-git-send-email-geert@linux-m68k.org> <520DE356.9060506@roeck-us.net>
In-Reply-To: <520DE356.9060506@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Alasdair Kergon <agk@redhat.com>, Joe Thornber <ejt@redhat.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Fri, Aug 16, 2013 at 01:31:18AM -0700, Guenter Roeck wrote:
> Is this patch going anyhere ? The problem breaks the sparc32:allmodconfig build,
> so it would be useful to get it fixed.

We're pulling together a batch of patches today, including this one.

Alasdair

