From: David Miller <davem@davemloft.net>
Date: Wed, 10 Jul 2013 20:42:31 +0000
Subject: Re: [PATCH] sparc32, leon: Require separate snoop tags set to regard snooping to be enabled
Message-Id: <20130710.134231.1250288508260529488.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1372688167-16432-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1372688167-16432-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon,  1 Jul 2013 16:16:07 +0200

> Even if data snooping is enabled, without separate snoop tags snooping will not
> work when the MMU is enabled.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied.
