From: David Miller <davem@davemloft.net>
Date: Wed, 18 Oct 2006 19:31:51 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <20061018.123151.95060906.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Wed, 18 Oct 2006 06:38:04 -0600

> 2.6.18 errors:
> kobject_add failed for isa@7 with -EEXIST, don't try to register things
> with the
>  same name in the same directory.

I fixed these recently, I believe the fix for that is in 2.6.18.1

I'll look into the IRQ problems but the power device registered it's
IRQ just fine on my SB100 in current 2.6.19-GIT.
