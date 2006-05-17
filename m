From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 17 May 2006 23:33:03 +0000
Subject: Re: klibc and SPARC
Message-Id: <20060517.163303.102879593.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e4g1ho$dae$1@terminus.zytor.com>
In-Reply-To: <e4g1ho$dae$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 17 May 2006 16:10:51 -0700

> Well, I'm happy to do it either which way.  I'll go ahead and write
> up an ad hoc solution for this case, unless it turns out to actually
> be bigger than one of the generic codes.

Note you could export these specific values via procfs/sysfs.

Just an idea...
