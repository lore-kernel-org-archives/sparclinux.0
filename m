From: David Miller <davem@davemloft.net>
Date: Sun, 24 Sep 2006 00:39:24 +0000
Subject: Re: [PATCH] no SA_NODEFER on sparc?
Message-Id: <20060923.173924.78710069.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
In-Reply-To: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: samuel.thibault@ens-lyon.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri, 8 Sep 2006 02:06:02 +0200

> I noticed that the sparc arch misses a definition for SA_NODEFER. Is
> that on purpose?  If not, here is a patch for fixing this.
> 
> Add SA_NODEFER, deprecating linuxish SA_NOMASK.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

I have no problems with this patch.  Userland headers already
define both SA_NODEFER and SA_NOMASK on Sparc.
