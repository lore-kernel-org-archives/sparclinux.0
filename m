From: David Miller <davem@davemloft.net>
Date: Wed, 30 Jul 2008 06:42:17 +0000
Subject: Re: [PATCH] sparc: merge of_platform_{32,64}.h
Message-Id: <20080729.234217.93335312.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080730145913.10c124a9.sfr@au.ibm.com>
In-Reply-To: <20080730145913.10c124a9.sfr@au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@au1.ibm.com
Cc: wli@holomorphy.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@au1.ibm.com>
Date: Wed, 30 Jul 2008 14:59:13 +1000

> The only difference between these files is that the 64 bit version has an
> extra declaration.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

The isa_bus_type is a vestige which I forgot to delete when I
removed the ISA bus layer from sparc and sparc64.  It can be
safely deleted.

I'm going to kill it, then rework your patch to go on top of that.

Thanks!
