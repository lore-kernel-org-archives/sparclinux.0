From: David Miller <davem@davemloft.net>
Date: Tue, 05 Aug 2014 03:47:16 +0000
Subject: Re: [PATCH] sparc: Add "install" target
Message-Id: <20140804.204716.1124163693809468133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David L Stevens <david.stevens@oracle.com>
Date: Fri, 25 Jul 2014 13:41:51 -0400

> This patches adds an "install" target to install kernel builds for SPARC,
> modeled after the i386 script.
> 
> Signed-off-by: David L Stevens <david.stevens@oracle.com>

Looks fine, I had to fix up a few things when I applied this:

> + 	fi

Sparc before TAB in indent.

> +cat $2 > $4/vmlinuz
> +cp $3 $4/System.map
> +

Empty line at EOF.

Anyways I fixed them up by hand and applied this, thanks!
