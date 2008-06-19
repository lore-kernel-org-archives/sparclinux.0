From: David Miller <davem@davemloft.net>
Date: Thu, 19 Jun 2008 23:10:05 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <20080619.161005.235931417.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670806190707k7ae6da8cud80a826a1603d941@mail.gmail.com>
	<a4423d670806190902l48c542e0i6a7380a2d3e7f520@mail.gmail.com>
In-Reply-To: <a4423d670806190902l48c542e0i6a7380a2d3e7f520@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Thu, 19 Jun 2008 20:02:44 +0400

> I have reverted this commit and
> 2.6.26-rc6-00233-g99d3b2d works fine. It can boot.

Thanks for your report, I'll look into this.

The irony is that this changeset was added to fix a
hang with lockdep enabled :-)
