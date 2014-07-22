From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2014 04:37:38 +0000
Subject: Re: [PATCH v3] sparc: Add support for seek and shorter read to /dev/mdesc
Message-Id: <20140721.213738.1831544429590257732.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1405696541-25189-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1405696541-25189-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 18 Jul 2014 09:15:40 -0600

> /dev/mdesc on Linux does not support reading arbitrary number
> of bytes and seeking while /dev/mdesc on Solaris does. This
> causes tools that work on Solaris to break on Linux. This patch
> adds these two capabilities to /dev/mdesc.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>

Applied to sparc-next, thanks.
