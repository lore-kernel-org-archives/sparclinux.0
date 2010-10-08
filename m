From: David Miller <davem@davemloft.net>
Date: Fri, 08 Oct 2010 18:52:26 +0000
Subject: Re: [PATCH] sparc: stop exporting openprom.h header
Message-Id: <20101008.115226.179923658.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101008173650.GH3863@angua.secretlab.ca>
	<20101008.104557.59696706.davem@davemloft.net>
	<20101008113424.2249c2df@debxo>
In-Reply-To: <20101008113424.2249c2df@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dilinger@queued.net
Cc: grant.likely@secretlab.ca, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org, devicetree-discuss@lists.ozlabs.org

From: Andres Salomon <dilinger@queued.net>
Date: Fri, 8 Oct 2010 11:34:24 -0700

> 
> It's unknown why openprom.h was being exported; there doesn't seem to be any
> reason for it currently, and it creates headaches with userspace being able
> to potentially use the structures in there.  So, don't export it anymore.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Acked-by: David S. Miller <davem@davemloft.net>
