From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 18 Jan 2006 00:00:57 +0000
Subject: Re: [PATCH] fix up sbuslib for new fb_comapt_ioctl prototype
Message-Id: <20060117.160057.92089766.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060115205554.GA19609@lst.de>
In-Reply-To: <20060115205554.GA19609@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Jan 2006 15:58:43 -0800

> We should all take a pledge to fix one warning per day ;)

Start sticking -Werror in a subdirectory from time to time :)
arch/sparc64 has had this for, I don't know, 2 years now.

Sam R. has a patch which allowed specifying things like this and it
worked very well.  I used this to pinpoint a bug on sparc64 not too
long ago.
