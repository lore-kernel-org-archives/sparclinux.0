From: David Miller <davem@davemloft.net>
Date: Fri, 12 Dec 2014 02:53:59 +0000
Subject: Re: [PATCH 1/3] vio: create routines for inc,dec vio dring indexes
Message-Id: <20141211.215359.389446932840941495.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1418318777-16453-1-git-send-email-dwight.engen@oracle.com>
In-Reply-To: <1418318777-16453-1-git-send-email-dwight.engen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 11 Dec 2014 12:26:15 -0500

> Both sunvdc and sunvnet implemented distinct functionality for incrementing
> and decrementing dring indexes. Create common functions for use by both
> from the sunvnet versions, which were chosen since they will still work
> correctly in case a non power of two ring size is used.
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>

Applied.
